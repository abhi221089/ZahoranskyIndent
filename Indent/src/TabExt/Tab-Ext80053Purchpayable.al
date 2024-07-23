tableextension 80053 PurchPayableext extends "Purchases & Payables Setup"
{
    fields
    {
        field(80000; "Indent No"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;

        }
        // Add changes to table fields here

        field(80001; "Indent Location"; Code[20])
        {
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;

        }
    }
}