table 80052 "Indent Line"
{
    DataCaptionFields = "Document No.", "No.";
    DrillDownPageId = "Indent Subform";
    LookupPageId = "Indent Subform";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            Editable = true;
            OptionCaption = 'Item,Service Item,Non-Inventory Item,GL, Fixed Asset';
            OptionMembers = Item,"Service Item","Non-Inventory Item",GL,"Fixed Asset";

            trigger OnValidate()
            begin
                GetIndentHeader();
                if "Line No." <> 0 then
                    if (Type <> xRec.Type) then begin
                        "No." := '';
                        Description := '';
                        Rec."Description 2" := '';
                        Rec."Description 3" := '';
                        "Location Code" := '';
                        "Shortcut Dimension 1 Code" := '';
                        "Shortcut Dimension 2 Code" := '';
                        Modify();
                    end;

                "User ID" := UserId;
                IndentHeader.TestField(IndentHeader."Required Date");
            end;
        }
        field(4; "No."; Code[20])
        {
            TableRelation = if (Type = filter(Item)) Item where(Blocked = const(false), Indent = const(true), Type = const(Inventory))
            else
            if (Type = filter("Service Item")) Item where(Blocked = const(false), Indent = const(true), Type = const(Service))
            else
            if (Type = filter("Non-Inventory Item")) Item where(Blocked = const(false), Indent = const(true), Type = const("Non-Inventory"))
            else
            if (Type = filter("Fixed Asset")) "Fixed Asset" where(Blocked = const(false))
            else
            if (Type = filter(GL)) "G/L Account" where(Blocked = const(false));

            trigger OnValidate()
            var
                ItemLedgerEntryLocal: Record "Item Ledger Entry";
                ItemLedgerEntryVendor: Record "Item Ledger Entry";
            begin

                if Type = Type::"Fixed Asset" then begin
                    IndentLine.Reset();
                    IndentLine.SetRange("Document No.", "Document No.");
                    IndentLine.SetRange("No.", "No.");
                    if IndentLine.FindFirst() then
                        Error('FA already selected');
                end;
                PurchPayableSetup.Get();

                GetIndentHeader();

                // IndentHeader.TESTFIELD("Required Date");
                // IndentHeader.TESTFIELD("Location Code");
                // IndentHeader.TESTFIELD("Shortcut Dimension 1 Code");
                // IndentHeader.TESTFIELD("Shortcut Dimension 2 Code");

                //CheckApprAndSentForAppr;
                UpdateFieldsFromHeader();

                case Type of
                    Type::Item:
                        begin
                            GetItemCode();
                            Item.Get("No.");
                            Validate(Description, Item.Description);
                            Validate("Description 2", Item."Description 2");
                            Validate("Unit Of Measure Code", Item."Base Unit of Measure");
                            Validate("Last Direct Cost", Item."Last Direct Cost");
                            Validate("Item Category Code", Item."Item Category Code");

                            ItemLedgerEntryLocal.Reset();
                            ItemLedgerEntryLocal.SetRange("Entry Type", ItemLedgerEntryLocal."Entry Type"::Purchase);
                            ItemLedgerEntryLocal.SetRange("Item No.", "No.");
                            if ItemLedgerEntryLocal.FindLast() then begin
                                Validate("Last Purchase Date", ItemLedgerEntryLocal."Posting Date");
                                Validate("Already Purchase", "Already Purchase"::Yes);
                            end;

                            ItemLedgerEntryVendor.Reset();
                            ItemLedgerEntryVendor.SetCurrentKey("Entry No.");
                            ItemLedgerEntryVendor.SetRange("Entry Type", ItemLedgerEntryVendor."Entry Type"::Purchase);
                            ItemLedgerEntryVendor.SetRange("Document Type", ItemLedgerEntryVendor."Document Type"::"Purchase Receipt");
                            ItemLedgerEntryVendor.SetRange("Source Type", ItemLedgerEntryVendor."Source Type"::Vendor);
                            ItemLedgerEntryVendor.SetRange("Item No.", "No.");
                            if ItemLedgerEntryVendor.FindLast() then
                                Validate("Vendor Code", ItemLedgerEntryVendor."Source No.")
                            else
                                Validate("Vendor Code", Item."Vendor No.");
                        end;

                    Type::"Service Item":
                        begin
                            GetItemCode();
                            Item.Get("No.");
                            Validate(Description, Item.Description);
                            Validate("Description 2", Item."Description 2");
                            Validate("Unit Of Measure Code", Item."Base Unit of Measure");
                            Validate("Last Direct Cost", Item."Last Direct Cost");
                            Validate("Item Category Code", Item."Item Category Code");

                            ItemLedgerEntryLocal.Reset();
                            ItemLedgerEntryLocal.SetRange("Entry Type", ItemLedgerEntryLocal."Entry Type"::Purchase);
                            ItemLedgerEntryLocal.SetRange("Item No.", "No.");
                            if ItemLedgerEntryLocal.FindLast() then begin
                                Validate("Last Purchase Date", ItemLedgerEntryLocal."Posting Date");
                                Validate("Already Purchase", "Already Purchase"::Yes);
                            end;

                            ItemLedgerEntryVendor.Reset();
                            ItemLedgerEntryVendor.SetCurrentKey("Entry No.");
                            ItemLedgerEntryVendor.SetRange("Entry Type", ItemLedgerEntryVendor."Entry Type"::Purchase);
                            ItemLedgerEntryVendor.SetRange("Document Type", ItemLedgerEntryVendor."Document Type"::"Purchase Receipt");
                            ItemLedgerEntryVendor.SetRange("Source Type", ItemLedgerEntryVendor."Source Type"::Vendor);
                            ItemLedgerEntryVendor.SetRange("Item No.", "No.");
                            if ItemLedgerEntryVendor.FindLast() then
                                Validate("Vendor Code", ItemLedgerEntryVendor."Source No.")
                            else
                                Validate("Vendor Code", Item."Vendor No.");
                        end;

                    Type::"Non-Inventory Item":
                        begin
                            GetItemCode();
                            Item.Get("No.");
                            Validate(Description, Item.Description);
                            Validate("Description 2", Item."Description 2");
                            Validate("Unit Of Measure Code", Item."Base Unit of Measure");
                            Validate("Last Direct Cost", Item."Last Direct Cost");
                            Validate("Item Category Code", Item."Item Category Code");

                            ItemLedgerEntryLocal.Reset();
                            ItemLedgerEntryLocal.SetRange("Entry Type", ItemLedgerEntryLocal."Entry Type"::Purchase);
                            ItemLedgerEntryLocal.SetRange("Item No.", "No.");
                            if ItemLedgerEntryLocal.FindLast() then begin
                                Validate("Last Purchase Date", ItemLedgerEntryLocal."Posting Date");
                                Validate("Already Purchase", "Already Purchase"::Yes);
                            end;

                            ItemLedgerEntryVendor.Reset();
                            ItemLedgerEntryVendor.SetCurrentKey("Entry No.");
                            ItemLedgerEntryVendor.SetRange("Entry Type", ItemLedgerEntryVendor."Entry Type"::Purchase);
                            ItemLedgerEntryVendor.SetRange("Document Type", ItemLedgerEntryVendor."Document Type"::"Purchase Receipt");
                            ItemLedgerEntryVendor.SetRange("Source Type", ItemLedgerEntryVendor."Source Type"::Vendor);
                            ItemLedgerEntryVendor.SetRange("Item No.", "No.");
                            if ItemLedgerEntryVendor.FindLast() then
                                Validate("Vendor Code", ItemLedgerEntryVendor."Source No.")
                            else
                                Validate("Vendor Code", Item."Vendor No.");
                        end;

                    Type::"Fixed Asset":
                        begin
                            FA.Get("No.");
                            Validate(Description, FA.Description);
                            Validate("Description 2", FA."Description 2");
                            Validate("Shortcut Dimension 1 Code", FA."Global Dimension 1 Code");
                            Validate("Shortcut Dimension 2 Code", FA."Global Dimension 2 Code");
                            Validate("Indent Quantity", 1);
                            Validate("FA Posting Group", FA."FA Posting Group");
                            if IndentHeader.Get(Rec."Document No.") then;
                            Validate("Location Code", IndentHeader."Location Code");
                        end;

                    Type::GL:
                        begin
                            RecGL.Get("No.");
                            Validate(Description, RecGL.Name);
                        end;

                end;

                if "No." = '' then begin
                    Validate(Description, '');
                    Validate("Description 2", '');
                    Validate("Unit Of Measure Code", '');
                    Validate("Last Direct Cost", 0);
                    Validate("Item Category Code", '');
                    Validate("Description 3", '');
                    Validate("Vendor Code", '');
                    Validate("Indent Quantity", 0);
                end;

                CalcFields("Available Stock");
            end;
        }
        field(5; Description; Text[100])
        {
            Editable = false;
        }
        field(6; "Description 2"; Text[50])
        {
            Editable = false;
        }
        field(7; "Indent Quantity"; Decimal)
        {
            Caption = 'PR Quantity';
            trigger OnValidate()
            begin
                // IF Type = Type::"Fixed Asset" THEN
                //         TESTFIELD("Indent Quantity", 1);
                if Rec.Posted then
                    Error('You can not edit the PR Quantity.');
                if Rec."Indent Quantity" > Rec."Remaining Qty" then
                    Error('Indent Quantity can not be more than Remaining Qty.');
            end;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                CheckApprAndSentForAppr();
            end;
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';

            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                CheckApprAndSentForAppr();
            end;
        }
        field(10; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Rejected,Closed';
            OptionMembers = Open,Released,"Pending for Approval",Rejected,Closed;
        }
        field(11; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(12; "Variant Code"; Code[10])
        {
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));

            trigger OnValidate()
            begin
                CheckApprAndSentForAppr();
            end;
        }
        field(13; "Shortcut Dimension 3 Code"; Code[20])
        {
            Editable = false;

            trigger OnLookup()
            begin
            end;

            trigger OnValidate()
            begin
            end;
        }
        field(14; "Shortcut Dimension 4 Code"; Code[20])
        {
            Editable = false;

            trigger OnLookup()
            begin
            end;
        }
        field(15; "Shortcut Dimension 5 Code"; Code[20])
        {
            Editable = false;

            trigger OnLookup()
            begin
            end;
        }
        field(16; "Shortcut Dimension 6 Code"; Code[20])
        {
            Editable = false;

            trigger OnLookup()
            begin
            end;
        }
        field(17; "Shortcut Dimension 7 Code"; Code[20])
        {
            Editable = false;

            trigger OnLookup()
            begin
            end;
        }
        field(18; "Shortcut Dimension 8 Code"; Code[20])
        {
            Editable = false;

            trigger OnLookup()
            begin
            end;
        }
        field(19; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(20; "Due Date"; Date)
        {
            Editable = false;
        }
        field(21; "Last Direct Cost"; Decimal)
        {
        }
        field(22; "Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(23; "Approved Quantity"; Decimal)
        {

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
                if ApprovalEntryTrack() then
                    Error('Modification can not be done after approval');

                if WaitingForApproval() then begin
                    ApprovalEntry.Reset();
                    // ApprovalEntry.SETRANGE("Table ID",DATABASE::Table50009);
                    ApprovalEntry.SetRange("Document No.", "Document No.");
                    ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                    if ApprovalEntry.FindFirst() then
                        if UpperCase(UserId) <> UpperCase(ApprovalEntry."Approver ID") then
                            Error('You are not authorised to change approved quantity after document has been sent for approval');
                end;

                if "Approved Quantity" > "Indent Quantity" then
                    Error('Approved Quantity can not be greater than Indent Quantity');

                GetIndentHeader();

                // "Line Amount" := "Approved Quantity"*"Last Direct Cost";
                // "Estimated Line Amount" := "Approved Quantity"*"Estimated Price";
                //
                // CALCFIELDS("Quantity on PO");
                // "Create PO Quantity" := "Outstanding Quantity";
                // "Outstanding Quantity" := "Approved Quantity" - "Quantity on PO";
            end;
        }
        field(24; "Short Closed"; Boolean)
        {
        }
        field(25; "Available Stock"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("No.")));
            Editable = false;

        }
        field(26; "Mark Approved"; Boolean)
        {

            trigger OnValidate()
            begin
                TestField(Description);

                if ApprovalProcess() then begin
                    if ApprovalEntryTrack() then
                        Error('Modification can not be done after approval');
                    if WaitingForApproval() then begin
                        GetIndentHeader();
                        UserSetup.Get(IndentHeader."Created By");
                        if UpperCase(UserId) <> UserSetup."Approver ID" then
                            Error('You are not authorised to change approved quantity after document has been sent for approval');
                    end;

                    GetIndentHeader();
                    IndentHeader.TestField(IndentHeader.Status, IndentHeader.Status::"Pending Approval");

                    UserSetup.Get(IndentHeader."Created By");
                    if UpperCase(UserId) <> UserSetup."Approver ID" then
                        Error('You are not authorised to approve the indent');
                end;
            end;
        }
        field(27; "Create PO Quantity"; Decimal)
        {
        }
        field(28; Posted; Boolean)
        {
            Editable = false;
        }
        field(29; "Indent Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Issue,Transfer';
            OptionMembers = " ",Issue,Transfer;
        }
        field(30; "Return Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = filter("Return Order"),
                                                             "Indent No." = field("Document No."),
                                                             "Indent Line No" = field("Line No.")));

        }
        field(31; "PO Creation USERID"; Code[50])
        {
        }
        field(32; Close; Boolean)
        {
        }
        field(33; Remarks; Text[100])
        {

            trigger OnValidate()
            begin
                CheckApprAndSentForAppr();
            end;
        }
        field(34; "Buyer Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Salesperson/Purchaser".Code where("Global Dimension 1 Code" = const('PURCHASE'));
        }
        field(35; "Buyer Name"; Text[50])
        {
            Editable = false;
        }
        field(36; "Estimated Price"; Decimal)
        {

            trigger OnValidate()
            begin
                CheckApprAndSentForAppr();
                "Estimated Line Amount" := "Approved Quantity" * "Estimated Price";
            end;
        }
        field(37; "Description 3"; Text[100])
        {
            Editable = false;
        }
        field(38; "Setup Location Code"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(39; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            Editable = false;
            TableRelation = "Item Category";
        }
        field(40; Make; Text[30])
        {
        }
        field(41; "Gen Req Close"; Boolean)
        {
        }
        field(42; "Service UOM"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(43; "MPS No."; Code[20])
        {
            Editable = false;
        }
        field(44; "MPS Line No."; Integer)
        {
            Editable = false;
        }
        field(45; "Shortcut Dimension 1 Name"; Text[50])
        {
            Editable = false;
        }
        field(46; "Shortcut Dimension 2 Name"; Text[50])
        {
            Editable = false;
        }
        field(47; "Month Purchase Quantity"; Decimal)
        {
            Editable = false;
        }
        field(48; "Month Purchase Value"; Decimal)
        {
            Editable = false;
        }
        field(49; "Year Purchase Quantity"; Decimal)
        {
            Editable = false;
        }
        field(50; "Year Purchase Value"; Decimal)
        {
            Editable = false;
        }
        field(51; "Already Purchase"; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(52; "Vendor Code"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if Vendor.Get("Vendor Code") then
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(54; "Min Level"; Decimal)
        {
            Editable = false;
        }
        field(55; "Last Purchase Date"; Date)
        {
        }
        field(56; "Location Code"; Code[20])
        {
            Editable = false;
            TableRelation = Location where("Use As In-Transit" = const(false));

            trigger OnValidate()
            begin
                CalcFields("Available Stock");
            end;
        }
        field(57; "Quantity on PO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Indent No." = field("Document No."),
                                                              "Indent Line No" = field("Line No."),
                                                              "No." = field("No.")));
            Editable = false;

        }
        field(58; "Quantity On MRN"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purch. Rcpt. Line".Quantity where("Indent No." = field("Document No."),
                                                                 "Indent Line No." = field("Line No."),
                                                                  "No." = field("No.")));
            Editable = false;

        }
        field(60; "Import Indent"; Boolean)
        {
        }
        field(61; "Vendor Name"; Text[50])
        {
            Editable = false;
        }
        field(62; "Outstanding Quantity"; Decimal)
        {
            Editable = false;
        }
        field(63; "Pending PO Quantity"; Decimal)
        {
            Editable = false;
        }
        field(64; Rejected; Boolean)
        {
        }
        field(65; "Select Line"; Boolean)
        {
        }
        field(66; Specifications; Text[50])
        {
        }
        field(67; "Quotation Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = filter(Quote),
                                                              "Indent No." = field("Document No."),
                                                              "Indent Line No" = field("Line No.")));

        }
        field(68; "PO Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document Type" = filter(Order),
                                                              "Indent No." = field("Document No."),
                                                              "Indent Line No" = field("Line No.")));

        }
        field(69; "MRN Quantity"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line".Quantity where("Indent No." = field("Document No."),
                                                                  "Indent Line No." = field("Line No.")));
            FieldClass = FlowField;
        }
        field(70; "Estimated Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(71; "Shortcut Dimension 3 Name"; Text[50])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Shortcut Dimension 3 Code"));
        }
        field(72; "Shortcut Dimension 4 Name"; Text[50])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Shortcut Dimension 4 Code"));
        }
        field(73; "Shortcut Dimension 5 Name"; Text[50])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Shortcut Dimension 5 Code"));
        }
        field(74; "Shortcut Dimension 6 Name"; Text[50])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Shortcut Dimension 6 Code"));
        }
        field(75; "Shortcut Dimension 7 Name"; Text[50])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Shortcut Dimension 7 Code"));
        }
        field(76; "Shortcut Dimension 8 Name"; Text[50])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Shortcut Dimension 8 Code"));
        }
        field(77; "Preferred Vendor"; Boolean)
        {

        }
        field(78; "FA Posting Group"; Code[20])
        {
            TableRelation = "FA Posting Group";
        }
        field(79; "User ID"; Code[30])
        {
        }
        field(80; "Transfer To"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(81; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                Rec."Remaining Qty" := Rec.Quantity;
            end;
        }
        field(82; "Quantity To Issue"; Decimal)
        {
            trigger OnValidate()
            begin
                if Rec."Quantity To Issue" > Rec."Remaining Qty" then
                    Error('You can only issue remaining Quantity.');
            end;
        }
        field(83; "Issued Quantity"; Decimal)
        {
        }
        field(84; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
        }
        field(85; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(86; "Remaining Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(87; "PO No."; Code[20])
        {
            Editable = false;
        }
        field(88; "PO Line No."; Integer)
        {
            Editable = false;
        }
        field(89; "Manaual PR"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(90; "Quality Required"; Boolean)
        {
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Shortcut Dimension 8 Code", "Document No.", "Due Date", "Posting Date")
        {
        }
        key(Key3; "Shortcut Dimension 7 Code", "No.", Type)
        {
        }
        key(Key4; "Shortcut Dimension 7 Code", "No.", Type, "Last Direct Cost")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        GetIndentHeader();
    end;

    trigger OnInsert()
    begin
        GetIndentHeader();
        UpdateFieldsFromHeader();
    end;

    trigger OnModify()
    begin
        GetIndentHeader();
    end;

    trigger OnRename()
    begin
        GetIndentHeader();
        UpdateFieldsFromHeader();
    end;


    procedure GetItemCode()
    begin
        Item.Get("No.");
    end;

    procedure GetIndentHeader()
    begin
        IndentHeader.Get("Document No.");
        if IndentHeader.Type <> Rec.Type then
            Error('Inventory Type and Line Type must be same.');
        //IndentHeader.TESTFIELD(Status, IndentHeader.Status::Open);
        if IndentHeader."Requisition Type" = IndentHeader."Requisition Type"::" " then
            Error('Requisition type can not be blank.');
        if IndentHeader."Indent Type" = IndentHeader."Indent Type"::" " then
            Error('Indent type can not be blank.');
        IndentHeader.TestField("Location Code");
        if IndentHeader."Indent Type" = IndentHeader."Indent Type"::Transfer then
            IndentHeader.TestField("Transfer To");

        IndentHeader.TestField("Shortcut Dimension 1 Code");
        IndentHeader.TestField("Shortcut Dimension 2 Code");
        IndentHeader.TestField("Shortcut Dimension 3 Code");
        IndentHeader.TestField("Shortcut Dimension 4 Code");
        IndentHeader.TestField("Shortcut Dimension 6 Code");

        if Item.Get(Rec."No.") then
            if Item."QC Required" <> IndentHeader."Quality Order" then
                Error('Please Select the items according to Quality Order.');

    end;

    procedure ApprovalEntryTrack(): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", "Document No.");
        if ApprovalEntry.FindLast() then
            if ApprovalEntry.Status = ApprovalEntry.Status::Approved then
                exit(true);
    end;

    procedure WaitingForApproval(): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", "Document No.");
        if ApprovalEntry.FindFirst() then
            if ApprovalEntry.Status = ApprovalEntry.Status::Rejected then
                exit(false)
            else
                exit(true);
    end;

    procedure CheckStatus(IndLine: Record "Indent Line"): Boolean
    var
        I: Integer;
    begin
        I := IndLine."Line No.";
        if I > 10000 then
            exit(true)
        else
            exit(false);
    end;

    procedure ApprovalProcess(): Boolean
    begin
        /*
        ApprovalTemplate.RESET;
        ApprovalTemplate.SETRANGE("Table ID",DATABASE::Table50009);
        ApprovalTemplate.SETRANGE("Document Type",ApprovalTemplate."Document Type"::Indent);
        ApprovalTemplate.SETRANGE(Enabled,TRUE);
        IF ApprovalTemplate.FINDFIRST THEN
          EXIT(TRUE);
        */

    end;

    procedure UpdateFieldsFromHeader()
    begin

        Status := IndentHeader.Status;
        "Posting Date" := IndentHeader."Posting Date";
        "Due Date" := IndentHeader."Due Date";
        "Location Code" := IndentHeader."Location Code";
        Posted := IndentHeader.Posted;
        "Indent Type" := IndentHeader."Indent Type";
        "Bin Code" := IndentHeader."Bin Code";
        Close := IndentHeader."Indent Closed";
        "Buyer Code" := IndentHeader."Buyer Code";
        "Buyer Name" := IndentHeader."Buyer Name";
        "MPS No." := IndentHeader."MPS No.";
        "Dimension Set ID" := IndentHeader."Dimension Set ID";
    end;

    local procedure CheckApprAndSentForAppr()
    begin
        if ApprovalEntryTrack() then
            Error('Modification can not be done after approval');
        if WaitingForApproval() then
            Error('Modification can not be done after document has been sent for approval');
    end;

    var
        FA: Record "Fixed Asset";
        RecGL: Record "G/L Account";
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        Item: Record Item;
        PurchPayableSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";

}

