table 80051 "Indent Header"
{
    DataCaptionFields = "No.";
    LookupPageId = "Indent List";
    DrillDownPageId = "Indent List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchPayableSetup.Get();
                    NoSeriesMgt.TestManual(PurchPayableSetup."Indent No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");

                if WaitingForApproval() then
                    Error('Modification can not be done after document has been sent for approval');

                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code") then
                    "Shortcut Dimension 1 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
            end;
        }
        field(3; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
                if WaitingForApproval() then
                    Error('Modification can not be done after document has been sent for approval');

                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code") then
                    "Shortcut Dimension 2 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(4; "Posting Date"; Date)
        {

            trigger OnValidate()
            begin
                if WaitingForApproval() then
                    Error('Modification can not be done after document has been sent for approval');
            end;
        }
        field(5; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Rejected, Short Closed';
            OptionMembers = Open,Released,"Pending Approval",Rejected,"Short Closed";
        }
        field(7; "Required Date"; Date)
        {

            trigger OnValidate()
            begin
                if WaitingForApproval() then
                    Error('Modification can not be done after document has been sent for approval');
                if "Required Date" < "Posting Date" then
                    Error('Due Date can not be less than posting date')
                else begin
                    GetIndentLine();
                    IndentLine.ModifyAll("Due Date", "Due Date");
                end;
            end;
        }
        field(8; "Created By"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(9; "Approved By"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(10; "Created Date"; Date)
        {
        }
        field(11; "Approved Date"; Date)
        {
        }
        field(12; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('COST CENTERS'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code") then
                    "Shortcut Dimension 3 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
            end;
        }
        field(13; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('Z GROUP'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code") then
                    "Shortcut Dimension 4 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 4 Code", "Shortcut Dimension 4 Code");
            end;
        }
        field(14; "Shortcut Dimension 5 Code"; Code[20])
        {
            //Editable = false;
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('EMPLOYEE'));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code") then
                    "Shortcut Dimension 5 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 5 Code", "Shortcut Dimension 5 Code");
            end;
        }
        field(15; "Shortcut Dimension 6 Code"; Code[20])
        {
            //Editable = false;
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));


            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code") then
                    "Shortcut Dimension 6 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 6 Code", "Shortcut Dimension 6 Code");
            end;
        }
        field(16; "Shortcut Dimension 7 Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
            end;

            trigger OnValidate()
            begin
                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code") then
                    "Shortcut Dimension 7 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 7 Code", "Shortcut Dimension 7 Code");
            end;
        }
        field(17; "Shortcut Dimension 8 Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
            end;

            trigger OnValidate()
            begin
                GlSetup.Get();
                if DimensionValue.Get(GlSetup."Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code") then
                    "Shortcut Dimension 8 Name" := DimensionValue.Name;

                GetIndentLine();
                IndentLine.ModifyAll("Shortcut Dimension 8 Code", "Shortcut Dimension 8 Code");
            end;
        }
        field(18; "Shortcut Dimension 1 Name"; Text[50])
        {
            Editable = false;
        }
        field(19; "Shortcut Dimension 2 Name"; Text[50])
        {
            Editable = false;
        }
        field(20; "Shortcut Dimension 3 Name"; Text[50])
        {
            Editable = false;
        }
        field(21; "Shortcut Dimension 4 Name"; Text[50])
        {
            Editable = false;
        }
        field(22; "Shortcut Dimension 5 Name"; Text[50])
        {
            Editable = false;
        }
        field(23; "Shortcut Dimension 6 Name"; Text[50])
        {
            Editable = false;
        }
        field(24; "Shortcut Dimension 7 Name"; Text[50])
        {
            Editable = false;
        }
        field(25; "Shortcut Dimension 8 Name"; Text[50])
        {
            Editable = false;
        }
        field(26; Description; Text[50])
        {
        }
        field(27; "MPS No."; Code[20])
        {
            Editable = false;
        }
        field(28; Type; Option)
        {
            OptionCaption = 'Item,Service Item,Non-Inventory Item,GL, Fixed Asset';
            OptionMembers = Item,"Service Item","Non-Inventory Item",GL,"Fixed Asset";

            trigger OnValidate()
            begin
                if WaitingForApproval() then
                    Error('Modification can not be done after document has been sent for approval');

                GetIndentLine();
                if IndentLine.FindFirst() then
                    Error('Indent Lines exists');
            end;
        }
        field(29; "Rejected By"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(30; "Rejected Date"; Date)
        {
        }
        field(31; Posted; Boolean)
        {

            trigger OnValidate()
            begin
                GetIndentLine();
                if IndentLine.FindFirst() then
                    IndentLine.ModifyAll(Posted, Posted);
            end;
        }
        field(32; "Buyer Code"; Code[10])
        {

            TableRelation = "Salesperson/Purchaser".Code where("Global Dimension 1 Code" = const('PURCHASE'));

            trigger OnValidate()
            begin
                if WaitingForApproval() then
                    Error('Modification can not be done after document has been sent for approval');
                if SalesPersonPurchaser.Get("Buyer Code") then
                    "Buyer Name" := SalesPersonPurchaser.Name
                else
                    "Buyer Name" := '';

                GetIndentLine();
                if IndentLine.FindSet() then
                    repeat
                        IndentLine."Buyer Code" := "Buyer Code";
                        IndentLine."Buyer Name" := "Buyer Name";
                        IndentLine.Modify();
                    until IndentLine.Next() = 0;
            end;
        }
        field(33; "Buyer Name"; Text[50])
        {
            Editable = false;
        }
        field(34; "Indent Closed"; Boolean)
        {
            Editable = false;
        }
        field(35; "Closed Remarks"; Text[100])
        {
        }
        field(36; "Closed By"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(37; "Closed On"; DateTime)
        {
            Editable = false;
        }
        field(38; "Reason Code"; Code[10])
        {
        }
        field(39; "Due Date"; Date)
        {
        }
        field(44; Remarks; Text[100])
        {
        }
        field(45; "Send To"; Text[30])
        {
        }
        field(46; "Customer Code"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Get("Customer Code");
                "Customer Name" := Cust.Name;
            end;
        }
        field(47; "Customer Name"; Text[50])
        {
            Editable = false;
        }
        field(48; "Customer Ship To"; Code[20])
        {
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Customer Code"));
        }
        field(49; "Customer PO No."; Code[50])
        {
        }
        field(50; "Requisition Type"; Option)
        {
            OptionCaption = ' ,Indent,MR';
            OptionMembers = " ",Indent,MR;
        }
        field(51; "Authorised By"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(52; "Indent Type"; Option)
        {
            OptionCaption = ' ,Issue,Transfer';
            OptionMembers = " ",Issue,Transfer;

            trigger OnValidate()
            begin
                GetIndentLine();
                IndentLine.ModifyAll("Indent Type", "Indent Type");
            end;
        }
        field(53; RFQ; Boolean)
        {
            Editable = false;
        }
        field(54; "Employee Code"; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Get("Employee Code");
                "Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
            end;
        }
        field(55; "Employee Name"; Text[61])
        {
            Editable = false;
        }
        field(56; "Location Code"; Code[20])
        {
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(57; "Import Indent"; Boolean)
        {
        }
        field(58; "Line Amount"; Decimal)
        {
            CalcFormula = sum("Indent Line"."Line Amount" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Estimated Price Line Amount"; Decimal)
        {
            CalcFormula = sum("Indent Line"."Estimated Line Amount" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Project Budget"; Code[10])
        {
            TableRelation = "G/L Budget Name";
        }
        field(61; "Short Received"; Boolean)
        {
        }
        field(62; "Parent PO"; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
        }
        field(63; "Preferred Vendor"; Boolean)
        {
            trigger OnValidate()
            var
            // validatecodeunit : Codeunit AllSubscriber;
            begin
                // validatecodeunit.referredVendorValidate();    
            end;


        }
        field(64; "Incoming Document Entry No"; Integer)
        {
        }
        field(65; "Transfer To"; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(66; "Bin Code"; Code[20])
        {
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
        }
        field(67; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(68; "Manaual PR"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(69; "Quality Order"; Boolean)
        {
            trigger OnValidate()
            begin
                IndentLine.Reset();
                IndentLine.SetRange("Document No.", "No.");
                if IndentLine.Find('-') then
                    Error(Text004, "No.");
            end;
        }
        field(50107; "Modified By"; Code[50])
        {
            Editable = false;
        }
        field(50108; "Modified On"; Date)
        {
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Indent Closed", false);

        IndentLine.Reset();
        IndentLine.SetRange("Document No.", "No.");
        if IndentLine.Find('-') then
            Error(Text001, "No.");
    end;

    trigger OnInsert()
    begin
        PurchPayableSetup.Get();
        GlSetup.Get();

        if "No." = '' then begin
            PurchPayableSetup.TestField("Indent No");
            NoSeriesCode := PurchPayableSetup."Indent No";
            NoSeriesMgt.InitSeries(NoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;

        "Posting Date" := WorkDate();
        "Created By" := UserId;
        "Created Date" := WorkDate();
        "Location Code" := PurchPayableSetup."Indent Location";
    end;

    trigger OnModify()
    begin
        TestField("Indent Closed", false);
        "Modified By" := UserId();
        "Modified On" := WorkDate();

    end;

    trigger OnRename()
    begin
        TestField("Indent Closed", false);
    end;

    var
        Cust: Record Customer;
        DimensionValue: Record "Dimension Value";
        Employee: Record Employee;
        GlSetup: Record "General Ledger Setup";
        IndentLine: Record "Indent Line";
        PurchPayableSetup: Record "Purchases & Payables Setup";
        SalesPersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesCode: Code[10];
        Text001: Label 'Indent Line already exists. To delete Indent No. %1, please delete all Indent Lines first.';
        Text004: Label 'Indent Line already exists. To change Quality order %1, please delete all Indent Lines first.';

    procedure AssistEdit(OldIndentHeader: Record "Indent Header"): Boolean
    begin
        PurchPayableSetup.Get();
        PurchPayableSetup.TestField("Indent No");
        NoSeriesCode := PurchPayableSetup."Indent No";
        if NoSeriesMgt.SelectSeries(NoSeriesCode, OldIndentHeader."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;

    procedure StatusReleased()
    begin
        CheckReleaseValidation();
        /*
        ApprovalTemplateExists;
        IF ApprovalTemplate.FINDFIRST THEN
          TESTFIELD("Approved By");
        */

        Status := Status::"Pending Approval";
        Modify();

    end;

    procedure StatusOpen()
    begin
        Status := Status::Open;
        Modify();
    end;

    procedure GetIndentLine()
    begin
        IndentLine.Reset();
        IndentLine.SetRange("Document No.", "No.");
        if IndentLine.FindFirst() then;
    end;

    procedure ApprovalTemplateExists()
    begin
        /*
        ApprovalTemplate.RESET;
        ApprovalTemplate.SETRANGE("Table ID",DATABASE::Table50009);
        ApprovalTemplate.SETRANGE("Document Type",ApprovalTemplate."Document Type"::Indent);
        ApprovalTemplate.SETRANGE(Enabled,TRUE);
        IF ApprovalTemplate.FINDFIRST THEN;
        */

    end;

    procedure CheckReleaseValidation()
    begin
        TestField("Posting Date");
        TestField("Required Date");

        PurchPayableSetup.Get();
        GlSetup.Get();

        GetIndentLine();
        IndentLine.SetFilter("Indent Quantity", '%1', 0);
        if IndentLine.FindFirst() then
            Error('You have not entered Indent Quantity at Indent Line No. = %1', IndentLine."Line No.");

        GetIndentLine();
    end;

    procedure WaitingForApproval(): Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", "No.");
        if ApprovalEntry.FindFirst() then
            if ApprovalEntry.Status = ApprovalEntry.Status::Rejected then
                exit(false)
            else
                exit(true);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

