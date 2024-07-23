tableextension 80056 fixedext extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here
        field(80000; "User ID"; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }
}