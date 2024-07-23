page 80206 "Posted Material Indent List"
{
    Caption = 'Purchase Request Orders';
    CardPageId = "Posted Material Indent";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Indent Header";
    SourceTableView = where(Posted = const(true),
                           "Manaual PR" = filter(false),
                            Status = filter(Released));

    layout
    {
        area(Content)
        {
            repeater(Genral)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified By field.';
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified On field.';
                }

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
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
        area(Navigation)
        {
            action("Quote Comparison")
            {
                Caption = 'Purchase Quote Comparison';
                ShortcutKey = 'Ctrl+C';
                Visible = true;
                ToolTip = 'Executes the Purchase Quote Comparison action.';

                trigger OnAction()
                begin
                    PurchLine.Reset();
                    PurchLine.SetRange("Indent No.", Rec."No.");
                    if PurchLine.FindFirst() then
                        Report.RunModal(50002, true, false, PurchLine);
                end;
            }
        }
    }

    var
        PurchLine: Record "Purchase Line";
}

