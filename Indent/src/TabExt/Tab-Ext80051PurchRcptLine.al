tableextension 80051 PurchRcptLineext1 extends "Purch. Rcpt. Line"
{
    fields
    {
        // Add changes to table fields here
        field(80001; "Indent No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(80002; "Indent Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
}