pageextension 80204 Purchorderext extends "Purchase Order"
{
    layout
    {
        addafter("Order Date")
        {

            field("Short Close"; Rec."Short Close")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Short Close field.';
            }
            field("Indent No"; Rec."Indent No")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Indent No. field.';

            }

        }


    }

    actions
    {
        addafter(CancelApprovalRequest)
        {
            action("PO Short Close")
            {
                Caption = 'PO Short Close';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Action;
                Visible = false;
                ToolTip = 'Executes the PO Short Close action.';
                trigger OnAction()
                var
                    PurchaseLine: Record "Purchase Line";
                    Text50001: TextConst ENU = 'Do you want to short close PO ?';
                begin
                    if Rec."Short Close" then
                        Error('PO has been already short closed');

                    if not Confirm(Text50001, false) then
                        exit;
                    if (Rec."Document Type" = Rec."Document Type"::Order) and (Rec.Status in [Rec.Status::Open, Rec.Status::Released]) then begin
                        Rec."Short Close" := true;
                        PurchaseLine.Reset();
                        PurchaseLine.SetCurrentKey("Document Type", "Document No.", "Line No.");
                        PurchaseLine.SetRange("Document Type", Rec."Document Type");
                        PurchaseLine.SetRange("Document No.", Rec."No.");
                        PurchaseLine.SetFilter("Outstanding Quantity", '>%1', 0);
                        if PurchaseLine.FindSet() then
                            repeat
                                PurchaseLine."Short Close Qty" := PurchaseLine."Outstanding Qty. (Base)";
                                PurchaseLine."Outstanding Amount" := 0;
                                PurchaseLine."Outstanding Amount (LCY)" := 0;
                                PurchaseLine."Outstanding Qty. (Base)" := 0;
                                PurchaseLine."Outstanding Quantity" := 0;
                                PurchaseLine."Qty. to Receive" := 0;
                                PurchaseLine."Short Close" := true;
                                PurchaseLine.Modify();
                            until PurchaseLine.Next() = 0
                        else
                            Error('Purchase line does not exist with outstanding quantity');
                        Message('PO has been short closed');
                    end;
                end;
            }
        }




    }
}