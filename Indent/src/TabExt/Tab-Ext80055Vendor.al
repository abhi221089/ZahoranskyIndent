tableextension 80055 Vendor1 extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(80000; "Prefered Vendor FA"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //    field(80001; Status; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionCaption = 'Open,Pending,Approved';
        //     OptionMembers = Open,Pending,Approved;
        // }




    }

    trigger OnInsert()
    begin
        CompanyInfoRec.Get();
        if CompanyInfoRec."Vendor Approval" then
            Rec.Blocked := Rec.Blocked::All;

    end;

    var
        CompanyInfoRec: Record "Company Information";
}