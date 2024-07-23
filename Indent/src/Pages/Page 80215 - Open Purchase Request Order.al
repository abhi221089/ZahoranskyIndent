page 80215 "Open Purchase Request Header"
{
    SourceTable = "Indent Header";
    Caption = 'Open Purchase Request Header';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PageEdit;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = PageEdit;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }

                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    Editable = PageEdit;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = PageEdit;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }

                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }

                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                }
            }
            part(IndentLine; "Open Purchase Request Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                SubPageView = sorting("Document No.", "Line No.");
                Editable = PageEdit;

            }
            group("Indent Information")
            {
                Caption = 'User Information';
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
            }
        }
        area(FactBoxes)
        {

        }
    }

    actions
    {
        area(Navigation)
        {


        }
        area(Processing)
        {
            action("Close Order")
            {
                Caption = 'Close Order';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Close Order action.';
                trigger OnAction()
                begin
                    Rec.TestField(Remarks);

                    if Confirm('Do you want to closed the order?') then begin
                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        if IndentLine.FindFirst() then
                            repeat
                                IndentLine.TestField(IndentLine."No.");
                            until IndentLine.Next() = 0;
                        Rec."Indent Closed" := true;
                        Rec.Modify();
                        Message('Order is closed.');
                    end else
                        exit;

                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Manaual PR" := true;
        Rec."Requisition Type" := Rec."Requisition Type"::MR;
        Rec."Indent Type" := Rec."Indent Type"::Issue;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Indent Closed" then
            PageEdit := false
        else
            PageEdit := true;
    end;

    var
        IndentLine: Record "Indent Line";
        PageEdit: Boolean;

    procedure GetIndentLines()
    begin
        IndentLine.Reset();
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.FindFirst() then;
    end;

}

