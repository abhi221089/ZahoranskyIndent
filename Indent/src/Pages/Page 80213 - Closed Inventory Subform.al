page 80213 "Closed Indent Subform"
{
    Caption = 'Posted Inventory Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    ApplicationArea = All;
    RefreshOnActivate = true;
    SourceTable = "Indent Line";

    layout
    {
        area(Content)
        {
            repeater(Genral)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Type field.';
                    trigger OnValidate()
                    begin
                        IndentHeader.Reset();
                        IndentHeader.SetRange("No.", Rec."Document No.");
                        if IndentHeader.FindFirst() then
                            Rec."Location Code" := IndentHeader."Location Code";

                    end;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnValidate()
                    var
                        indenthed: Record "Indent Header";
                    begin
                        indenthed.Reset();
                        indenthed.SetRange("No.", Rec."Document No.");
                        if indenthed.FindFirst() then
                            if indenthed.Status = indenthed.Status::Released then
                                Error('Status Must be Open');

                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = DescriptionEditable;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Editable = DescriptionEditable;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Vendor Code field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.';
                    trigger OnValidate()
                    var
                        indenthed: Record "Indent Header";
                    begin
                        indenthed.Reset();
                        indenthed.SetRange("No.", Rec."Document No.");
                        if indenthed.FindFirst() then
                            if indenthed.Status = indenthed.Status::Released then
                                Error('Status Must be Open');

                    end;
                }
                field("Available Stock"; Rec."Available Stock")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Available Stock field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    trigger OnValidate()
                    var
                        indenthed: Record "Indent Header";
                    begin
                        indenthed.Reset();
                        indenthed.SetRange("No.", Rec."Document No.");
                        if indenthed.FindFirst() then
                            if indenthed.Status = indenthed.Status::Released then
                                Error('Status Must be Open');

                    end;
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity To Issue field.';
                }
                field("Indent Quantity"; Rec."Indent Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PR Quantity field.';
                }
                field("Issued Quantity"; Rec."Issued Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issued Quantity field.';
                }

                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Direct Cost field.';
                }
                field("Last Purchase Date"; Rec."Last Purchase Date")
                {
                    ApplicationArea = All;
                    Editable = edit;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Last Purchase Date field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line Amount field.';
                    trigger OnValidate()
                    var
                        indenthed: Record "Indent Header";
                    begin
                        indenthed.Reset();
                        indenthed.SetRange("No.", Rec."Document No.");
                        if indenthed.FindFirst() then
                            if indenthed.Status = indenthed.Status::Released then
                                Error('Status Must be Open');

                    end;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Ite&m Card")
            {
                Caption = 'Ite&m Card';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the Ite&m Card action.';

                trigger OnAction()
                begin
                    Rec.TestField(Type, Type::Item);
                    Rec.TestField("No.");
                    GetItem(Rec."No.");
                    Page.RunModal(Page::"Item Card", Item);



                end;
            }
        }
    }
    // trigger OnOpenPage()
    // var
    //     myInt: Integer;
    // begin
    //      IF rec.Status = rec.Status::Released THEN
    //       Edit := TRUE;
    // end;

    var
        IndentHeader: Record "Indent Header";
        Item: Record Item;
        [InDataSet]
        DescriptionEditable: Boolean;
        edit: Boolean;

    procedure GetItem("No.": Code[20])
    begin
        Item.Get("No.");
    end;

    procedure ShowLineComment()
    begin
        Rec.TestField("Document No.");
        Rec.TestField("Line No.");
    end;

    local procedure TypeOnAfterValidate()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
    end;
}

