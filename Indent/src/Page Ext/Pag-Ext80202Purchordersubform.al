pageextension 80202 PurchlineExt extends "Purchase Order Subform"
{
    layout
    {
        addafter("Qty. to Receive")
        {

            field("Short Close"; Rec."Short Close")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Short Close field.';

            }

        }

        // Add changes to page layout here
        addafter(Quantity)
        {

            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. per Unit of Measure field.';

            }

        }
        modify("Qty. to Receive")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Short Close" = true then
                    Error('Short Close Must False');
            end;
        }
    }

    actions
    {
        addafter("O&rder")
        {

            action("PO Short Close")
            {
                Caption = 'Short Close';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Action;
                ToolTip = 'Executes the Short Close action.';
                trigger OnAction()
                var
                    PurchaseLine: Record "Purchase Line";
                    Text50001: TextConst ENU = 'Do you want to  close selected Line ?';
                begin
                    if Rec."Short Close" then
                        Error('line has been already  closed');

                    if not Confirm(Text50001, false) then
                        exit;
                    if (Rec."Document Type" = Rec."Document Type"::Order) and (Rec.Status in [Rec.Status::Open, Rec.Status::Closed]) then begin
                        Rec."Short Close" := true;
                        PurchaseLine.Reset();
                        PurchaseLine.SetCurrentKey("Document Type", "Document No.", "Line No.");
                        // PurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                        // PurchaseLine.SETRANGE("Document No.", Rec."No.");
                        CurrPage.SetSelectionFilter(PurchaseLine);
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
                        Message('line has been short closed');
                    end;
                end;
            }

        }
    }
}