table 80053 "Indent Vendor"
{
    Permissions = tabledata "Indent Vendor" = rim;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Indent No."; Code[20])
        {
            TableRelation = "Indent Header"."No.";
        }
        field(2; "Indent Line No."; Integer)
        {
        }
        field(3; "Vendor Code"; Code[20])
        {
            TableRelation = Vendor where(Blocked = filter(<> All));

            trigger OnValidate()
            begin

                if Vendor.Get(Rec."Vendor Code") then;
                Rec."Vendor Name" := Vendor.Name;

                if Vendor."Prefered Vendor FA" = true then begin
                    IndentLine.Reset();
                    IndentLine.SetRange("Document No.", Rec."Indent No.");
                    IndentLine.SetRange("Line No.", Rec."Indent Line No.");
                    if IndentLine.FindFirst() then
                        // IndentLine."Preferred Vendor" := Vendor."Prefered Vendor FA";
                        IndentLine.Modify();
                end;


            end;
        }
        field(4; Cost; Decimal)
        {

            trigger OnValidate()
            begin

                if Rec."Vendor Code" <> '' then begin
                    IndentLine.Reset();
                    IndentLine.SetRange("Document No.", Rec."Indent No.");
                    IndentLine.SetRange("Line No.", Rec."Indent Line No.");
                    if IndentLine.FindFirst() then
                        //  Rec."FA Posting Group" := IndentLine."FA Posting Group";
                        Rec.Modify();
                end;

            end;
        }
        field(5; "Order"; Boolean)
        {
            Editable = true;
        }
        field(6; "Preferred Vendor"; Boolean)
        {

        }
        field(7; "FA Posting Group"; Code[20])
        {

        }
        field(8; "Best Price Vendor"; Boolean)
        {
        }
        field(9; "Create PO"; Boolean)
        {

        }
        field(10; Comments; Text[100])
        {
        }
        field(11; "Vendor Name"; Text[100])
        {
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Indent No.", "Indent Line No.", "Vendor Code")
        {
        }
        key(Key2; "Indent No.", "Vendor Code")
        {
        }
        key(Key3; "Vendor Code")
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnModify()
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Indent No", Rec."Indent No.");
        if PurchaseHeader.FindFirst() then
            Error('Purchase Order is already created.');
    end;

    trigger OnInsert()
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Indent No", Rec."Indent No.");
        if PurchaseHeader.FindFirst() then
            Error('Purchase Order is already created.');
    end;

    trigger OnDelete()
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Indent No", Rec."Indent No.");
        if PurchaseHeader.FindFirst() then
            Error('Purchase Order is already created.');
    end;

    var
        IndentLine: Record "Indent Line";
        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
}

