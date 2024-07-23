page 80216 "Open Purchase Request Subform"
{
    Caption = 'Open Purchase Request Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Indent Line";
    ApplicationArea = All;

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


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Item &Vendor")
            {
                Caption = 'Item &Vendor';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = page "Indent Vendor";
                RunPageLink = "Indent No." = field("Document No."),
                              "Indent Line No." = field("Line No.");
                RunPageView = sorting("Indent No.", "Indent Line No.", "Vendor Code");
                ToolTip = 'Executes the Item &Vendor action.';
            }
        }
    }


    var
        IndentHeader: Record "Indent Header";
        Item: Record Item;
        DescriptionEditable: Boolean;

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

