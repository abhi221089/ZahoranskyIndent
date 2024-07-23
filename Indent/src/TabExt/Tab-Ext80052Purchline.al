tableextension 80052 Purchaselineext2 extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(80001; "Indent No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(80002; "Indent Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(80003; "Indent Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(80004; "Indent Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,RM,Project,Consumables;
        }
        // field(80005; "Yield Qty"; Decimal)
        // {

        //     DecimalPlaces = 0 : 5;
        //     DataClassification = ToBeClassified;

        //     // trigger OnValidate()
        //     // var
        //     //     qty : Decimal;
        //     // begin
        //     //     if
        //     //     Rec."Document Type" =rec."Document Type"::Order then begin
        //     //     qty:=  "Yield Qty"/rec."Qty. to Receive";
        //     //     rec."Qty. per Unit of Measure":= qty;
        //     //     rec."Outstanding Qty. (Base)" := rec."Outstanding Quantity"*rec."Qty. per Unit of Measure";
        //     //     rec."Qty. to Invoice (Base)" := rec."Qty. to Invoice"*rec."Qty. per Unit of Measure";
        //     //     rec."Qty. to Receive (Base)" := rec."Qty. to Receive"*rec."Qty. per Unit of Measure";
        //     //   //  rec."Qty. Rcd. Not Invoiced (Base)" := rec."Qty. Rcd. Not Invoiced"*rec."Qty. per Unit of Measure";
        //     //    // rec."Qty. Received (Base)" := rec."Quantity Received"*rec."Qty. per Unit of Measure";
        //     //    // rec."Qty. Invoiced (Base)" := rec."Quantity Invoiced" *rec."Qty. per Unit of Measure";
        //     //     rec."Quantity (Base)" := rec.Quantity*rec."Qty. per Unit of Measure";
        //     // end;
        //     // end;
        // }
        // field(80006; "Base Unit of Measure"; code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = false;

        // }
        field(80007; "Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(80009; "Short Close Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}