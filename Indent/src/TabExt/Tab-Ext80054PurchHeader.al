tableextension 80054 purchhederext extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(80001; "Indent No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Indent No.';
        }
        field(80003; "Best Price Quote"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(80004; "Indent Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,RM,Project,Consumables;
        }
        field(80005; "Short Close"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}