page 80208 "Released Indent List"
{
    Caption = 'Released Inventory Orders';
    CardPageId = "Released Indent Header";
    PageType = List;
    DeleteAllowed = false;
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Indent Header";
    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Manaual PR" = filter(false), RFQ = filter(false), Status = filter(Released), "Indent Closed" = const(false));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("MPS No."; Rec."MPS No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the MPS No. field.';
                }
                field("Estimated Price Line Amount"; Rec."Estimated Price Line Amount")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Estimated Price Line Amount field.';
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }

            }
        }
    }

    actions
    {
    }
}

