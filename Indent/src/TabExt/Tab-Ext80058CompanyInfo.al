tableextension 80058 CompanyInfoext extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(70000; "Item Approval"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70001; "Vendor Approval"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70002; "Customer Approval"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}