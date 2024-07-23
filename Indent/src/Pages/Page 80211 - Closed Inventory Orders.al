page 80211 "Closed Indent List"
{
    Caption = 'Posted Inventory Orders';
    CardPageId = "Closed Indent Header";
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Indent Header";
    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Manaual PR" = filter(false), "Indent Closed" = const(true));

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
                field("Project Budget"; Rec."Project Budget")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Project Budget field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Parent PO"; Rec."Parent PO")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Parent PO field.';
                }
            }
        }
    }

    actions
    {
    }
}

