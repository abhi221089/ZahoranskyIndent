report 80051 "Quote Comparison"
{

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Quote Comparison.rdlc';

    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = order(ascending)
                                where("Document Type" = filter(Quote));
            RequestFilterFields = "Indent No.";
            column(USERID; UserId)
            {
            }
            column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
            {
            }
            column(POcode; POcode)
            {
            }
            column(POdate; Format(POdate))
            {
            }
            column(Lastcost; Lastcost)
            {
            }
            column(CompName; CompName)
            {
            }
            column(CompAddress; CompAddress)
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone_No_; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Fax_No_; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Post_Code_; CompanyInfo."Post Code")
            {
            }
            column(LocAddress; LocAddress)
            {
            }
            column(i; i)
            {
            }
            column(No_PurchaseLines; "Purchase Line"."No.")
            {
            }
            column(IndentNo_PurchaseLine; "Purchase Line"."Indent No.")
            {
            }
            column(UnitofMeasure_PurchaseLine; IndentLine."Unit Of Measure Code")
            {
            }
            column(Description_PurchaseLine; "Purchase Line".Description)
            {
            }
            column(Description2_PurchaseLine; "Purchase Line"."Description 2")
            {
            }
            column(Quantity_PurchaseLine; "Purchase Line".Quantity)
            {
            }
            column(BuyfromVendorNo_PurchaseLine; "Purchase Line"."Buy-from Vendor No.")
            {
            }
            column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            column(RecVendor_Name; RecVendor."No." + ' - ' + RecVendor.Name)
            {
            }
            column(RecVendor_No_City; ' Contact No. :   ' + RecVendor."Phone No." + '   ' + RecVendor.City)
            {
            }

            column(todaydate; TodayDate)
            {
            }
            column(CurrentTime; Time)
            {
            }
            column(PFAmt; "P&FAmt")
            {
            }
            column(MissCharges1; MissCharges[1])
            {
            }
            column(MissCharges2; MissCharges[2])
            {
            }
            column(MissCharges3; MissCharges[3])
            {
            }
            column(MissCharges4; MissCharges[4])
            {
            }
            column(MissCharges5; MissCharges[5])
            {
            }
            column(MissCharges6; MissCharges[6])
            {
            }
            column(MissCharges7; MissCharges[7])
            {
            }
            column(MissCharges8; MissCharges[8])
            {
            }
            column(MissAmt1; MissAmt[1])
            {
            }
            column(MissAmt2; MissAmt[2])
            {
            }
            column(MissAmt3; MissAmt[3])
            {
            }
            column(MissAmt4; MissAmt[4])
            {
            }
            column(MissAmt5; MissAmt[5])
            {
            }
            column(MissAmt6; MissAmt[6])
            {
            }
            column(MissAmt7; MissAmt[7])
            {
            }
            column(MissAmt8; MissAmt[8])
            {
            }
            column(RemarksText; RemarksText)
            {
            }
            column(ShortcutDimension1Code_PurchaseLine; "Purchase Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseLine; "Purchase Line"."Shortcut Dimension 2 Code")
            {
            }

            column(QuotedPrice; QuotedPrice)
            {
            }
            column(FreightAmt; FreightAmt)
            {
            }
            column(P_Famt; P_Famt)
            {
            }
            column(LineDiscount_PurchaseLine; "Purchase Line"."Line Discount %")
            {
            }
            column(ExDutyPer; ExDutyPer)
            {
            }


            column(PayTermsDis; PayTermsDis)
            {
            }
            column(DeliveryTerms; DeliveryTerms)
            {
            }
            column(TotalQty; TotalQty)
            {
            }
            column(CreatedBy_PurchHdr; UserName)
            {
            }
            column(short1; short1)
            {

            }
            column(short2; short2)
            {

            }
            column(cost; cost)
            {

            }
            column(IndentVendorcost; IndentVendor.Cost)
            {

            }



            trigger OnAfterGetRecord()
            begin
                RecLocation.Reset();
                RecLocation.SetRange(Code, "Location Code");
                if RecLocation.FindFirst() then;
                RecVendor.Get("Purchase Line"."Buy-from Vendor No.");
                PurchHeader.Get(0, "Document No.");

                if (ItemNo <> "No.") or (IndentNo <> "Indent No.") then begin
                    ItemNo := "No.";
                    IndentNo := "Indent No.";
                    i += 1;
                end;



                J := 1;
                k := 1;
                FreightAmt := 0;
                P_Famt := 0;
                Clear(MissCharges);
                Clear(MissAmt);


                Lastcost := 0;
                if RecItem.Get("No.") then
                    Lastcost := RecItem."Last Direct Cost";

                POdate := 0D;
                POcode := '';

                RecPL.Reset();
                RecPL.SetRange("No.", "No.");
                if RecPL.FindLast() then
                    POcode := RecPL."Document No.";
                POdate := RecPL."Order Date";

                PLArch.SetRange("Document Type", "Document Type");
                PLArch.SetRange("Document No.", "Document No.");
                PLArch.SetRange("No.", "No.");
                if PLArch.FindFirst() then
                    QuotedPrice := PLArch."Direct Unit Cost"
                else
                    QuotedPrice := "Direct Unit Cost";

                if PaymentTerms.Get(PurchHeader."Payment Terms Code") then
                    PayTermsDis := PaymentTerms.Description
                else
                    PayTermsDis := '';

                ShpMthd.Reset();
                if ShpMthd.Get(PurchHeader."Shipment Method Code") then
                    DeliveryTerms := ShpMthd.Description
                else
                    DeliveryTerms := '';

                IndentLine.SetRange("Document No.", "Indent No.");
                if IndentLine.FindFirst() then begin
                    IndentLine.CalcSums("Indent Quantity");
                    TotalQty := IndentLine."Indent Quantity";
                    short1 := IndentLine."Shortcut Dimension 1 Code";
                    short2 := IndentLine."Shortcut Dimension 2 Code"
                end;

                IndentVendor.Reset();
                IndentVendor.SetRange("Indent No.", "Purchase Line"."Indent No.");
                IndentVendor.SetRange("Indent Line No.", "Purchase Line"."Indent Line No");
                IndentVendor.SetRange("Vendor Code", "Purchase Line"."Buy-from Vendor No.");
                if IndentVendor.FindSet() then
                    repeat
                        cost := IndentVendor.Cost;
                    until IndentVendor.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
                "Purchase Line".SetCurrentKey("No.");
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                CompName := CompanyInfo.Name + ' ' + CompanyInfo."Name 2";
                CompAddress := CompanyInfo.Address + '' + CompanyInfo."Address 2";
                if "Purchase Line".GetFilter("Purchase Line"."Indent No.") = '' then
                    Error('Indent No. is Mandatory.');
                TodayDate := FormatDate(Today);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }

        trigger OnInit()
        begin
            Clear("Purchase Line"."Indent No.");
        end;

        trigger OnOpenPage()
        begin
            Clear("Purchase Line"."Indent No.");
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        IndentLine: Record "Indent Line";
        IndentVendor: Record "Indent Vendor";
        RecItem: Record Item;
        RecLocation: Record Location;
        PaymentTerms: Record "Payment Terms";
        PurchHeader: Record "Purchase Header";
        RecPL: Record "Purchase Line";
        PLArch: Record "Purchase Line Archive";
        ShpMthd: Record "Shipment Method";
        RecVendor: Record Vendor;
        IndentNo: Code[20];
        ItemNo: Code[20];
        MissCharges: array[8] of Code[20];
        POcode: Code[20];
        short1: Code[20];
        short2: Code[20];
        POdate: Date;
        cost: Decimal;
        ExDutyPer: Decimal;
        FreightAmt: Decimal;
        Lastcost: Decimal;
        MissAmt: array[8] of Decimal;
        P_Famt: Decimal;
        "P&FAmt": Decimal;
        QuotedPrice: Decimal;
        TotalAmt: Decimal;
        TotalQty: Decimal;
        i: Integer;
        J: Integer;
        k: Integer;
        RemarksText: Text;
        TodayDate: Text;
        DeliveryTerms: Text[50];
        PayTermsDis: Text[50];
        UserName: Text[80];
        CompAddress: Text[100];
        CompName: Text[100];
        LocAddress: Text[100];

    procedure FormatDate(SourceDate: Date): Text[10]
    var
        DateIn: Text[2];
        Month: Text[2];
        Year: Text[4];
    begin
        Year := Format(Date2DMY(SourceDate, 3));
        Month := Format(Date2DMY(SourceDate, 2));
        DateIn := Format(Date2DMY(SourceDate, 1));

        if StrLen(Month) < 2 then
            Month := '0' + Month;

        if StrLen(DateIn) < 2 then
            DateIn := '0' + DateIn;
        exit(DateIn + '-' + Month + '-' + Year);
    end;
}

