pageextension 80205
 PurchasePayableSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posted Delivery Challan Nos.")
        {
            field("Indent Location"; Rec."Indent Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Indent Location field.';

            }
            field("Indent No"; Rec."Indent No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Indent No field.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
}