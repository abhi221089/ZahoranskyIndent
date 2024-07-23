pageextension 80203 CompanyInfoext extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter("Post Code")
        {
            field("Item Approval"; Rec."Item Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Approval field.';

            }
            field("Vendor Approval"; Rec."Vendor Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Approval field.';
            }
            field("Customer Approval"; Rec."Customer Approval")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Approval field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}