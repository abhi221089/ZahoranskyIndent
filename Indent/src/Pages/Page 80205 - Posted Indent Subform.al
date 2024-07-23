page 80205 "Posted Indent Subform"
{
    Caption = 'Purchase Request Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    Permissions = tabledata "Indent Line" = rimd;
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
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.';
                }
                field("Indent Quantity"; Rec."Indent Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PR Quantity field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PO No. field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
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
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Executes the Ite&m Card action.';

                trigger OnAction()
                begin
                    Rec.TestField(Type, Type::Item);
                    Rec.TestField("No.");
                    GetItem(Rec."No.");
                    Page.RunModal(Page::"Item Card", Item)
                end;
            }
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

    trigger OnAfterGetRecord()
    begin

        Rec.CalcFields("Quantity on PO");
        Rec.CalcFields("Quantity On MRN");

        Rec."Pending PO Quantity" := Rec."Quantity on PO" - Rec."Quantity On MRN";
        Rec."Outstanding Quantity" := Rec."Approved Quantity" - Rec."Pending PO Quantity" - Rec."Quantity On MRN";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec.CalcFields("Quantity on PO");
        Rec.CalcFields("Quantity On MRN");

        Rec."Pending PO Quantity" := Rec."Quantity on PO" - Rec."Quantity On MRN";
        Rec."Outstanding Quantity" := Rec."Approved Quantity" - Rec."Pending PO Quantity" - Rec."Quantity On MRN";
    end;


    var
        IndentHeader: Record "Indent Line";
        Item: Record Item;

    procedure GetItem("No.": Code[20])
    begin
        //Item.GET("No.");
    end;

    procedure ShowLineComment()
    begin
        Rec.TestField("Document No.");
        Rec.TestField("Line No.");
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if IndentHeader.Get(Rec."Document No.") then
            Rec.Type := IndentHeader.Type;
    end;

    local procedure OnActivateForm()
    begin
        IndentHeader.Get(Rec."Document No.");
        Rec.Type := IndentHeader.Type;
    end;
}

