page 80207 "Indent Vendor"
{
    PageType = List;
    SourceTable = "Indent Vendor";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Vendor Code"; Rec."Vendor Code")
                {
                    Editable = RecordEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Code field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = RecordEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }

                field(Cost; Rec.Cost)
                {
                    Editable = RecordEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost field.';
                }
                field("Create PO"; Rec."Create PO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Create PO field.';
                }
                field(Order; Rec.Order)
                {
                    Editable = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Order field.';

                }
                field(Comments; Rec.Comments)
                {
                    Editable = RecordEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';

                }

            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Update for all Item")
            {
                Visible = false;
                ToolTip = 'Executes the Update for all Item action.';
                trigger OnAction()
                begin

                    //  CurrPage.SETSELECTIONFILTER(Rec);
                    if Rec.FindFirst() then
                        repeat
                            if Rec."Vendor Code" <> '' then begin
                                IndentLine.Reset();
                                IndentLine.SetRange("Document No.", Rec."Indent No.");
                                IndentLine.SetFilter("Line No.", '<>%1', Rec."Indent Line No.");
                                IndentLine.SetRange("FA Posting Group", Rec."FA Posting Group");
                                if IndentLine.FindFirst() then
                                    repeat
                                        IndentVendor.Init();
                                        IndentVendor."Indent No." := IndentLine."Document No.";
                                        IndentVendor."Indent Line No." := IndentLine."Line No.";
                                        IndentVendor."Vendor Code" := Rec."Vendor Code";
                                        IndentVendor.Cost := Rec.Cost;
                                        IndentVendor."FA Posting Group" := Rec."FA Posting Group";//21884
                                        IndentVendor.Insert(true);
                                        // IndentLine."Preferred Vendor" := TRUE;
                                        IndentLine.Modify();
                                    until IndentLine.Next() = 0;
                            end;
                        until Rec.Next() = 0;
                    Message('Updated');
                end;

            }
            action("Get Vendor")
            {
                Caption = 'Get Price List';
                ToolTip = 'Executes the Get Price List action.';
                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to get all the vendors from Purchase Price ?') then
                        exit;

                    IndentLine.SetRange("Document No.", Rec."Indent No.");
                    IndentLine.SetRange("Line No.", Rec."Indent Line No.");
                    if IndentLine.FindFirst() then begin
                        PurchasePrice.Reset();
                        PurchasePrice.SetRange("Item No.", IndentLine."No.");
                        if PurchasePrice.FindFirst() then
                            repeat
                                PurchasePrice1.Reset();
                                PurchasePrice1.SetCurrentKey("Vendor No.", "Starting Date");
                                PurchasePrice1.SetRange("Item No.", IndentLine."No.");
                                PurchasePrice1.SetRange("Vendor No.", PurchasePrice."Vendor No.");
                                if PurchasePrice1.FindLast() then
                                    if (VendorCode <> PurchasePrice."Vendor No.") then begin
                                        IndentVendor.Init();
                                        IndentVendor."Indent No." := IndentLine."Document No.";
                                        IndentVendor."Indent Line No." := IndentLine."Line No.";
                                        IndentVendor.Validate("Vendor Code", PurchasePrice1."Vendor No.");
                                        VendorCode := PurchasePrice1."Vendor No.";
                                        IndentVendor.Insert();
                                        IndentVendor.Validate(Cost, PurchasePrice1."Direct Unit Cost");
                                        IndentVendor."FA Posting Group" := Rec."FA Posting Group";//21884
                                        IndentVendor.Modify();
                                    end;
                            until PurchasePrice.Next() = 0;
                    end;
                    IndentVendor.SetRange("Vendor Code", '');
                    if IndentVendor.FindFirst() then
                        IndentVendor.Delete();

                    Message('Updated');
                end;

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Order = true then
            RecordEditable := false
        else
            RecordEditable := true;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Order then
            Error(Text001);


        IndentLine.Reset();
        IndentLine.SetRange("Document No.", Rec."Indent No.");
        IndentLine.SetRange("Line No.", Rec."Indent Line No.");
        if IndentLine.FindFirst() then begin
            IndentLine."Preferred Vendor" := false;
            IndentLine.Modify();
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        RecordEditable := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Order = true then
            RecordEditable := false
        else
            RecordEditable := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // IndentVendor.RESET;
        // IndentVendor.SETRANGE("Indent No.", Rec."Indent No.");
        // IndentVendor.SetRange("Indent Line No.", rec."Indent Line No.");
        // IF IndentVendor.FINDFIRST THEN
        //     REPEAT
        //         IndentVendor.TESTFIELD(IndentVendor.Cost);
        //     UNTIL IndentVendor.NEXT = 0;
    end;

    var
        IndentLine: Record "Indent Line";
        IndentVendor: Record "Indent Vendor";
        PurchasePrice: Record "Purchase Price";
        PurchasePrice1: Record "Purchase Price";
        RecordEditable: Boolean;
        VendorCode: Code[20];
        Text001: Label 'You can not delete the record where Quotation = TRUE';
}

