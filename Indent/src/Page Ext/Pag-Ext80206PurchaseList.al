pageextension 80206 "PurchaseOrderList Ext" extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor Name")
        {

            field("Indent No"; Rec."Indent No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Indent No. field.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
}