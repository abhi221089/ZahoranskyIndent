pageextension 80200 purchquoteExt1 extends "Purchase Quote"
{

    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Best Price Quote"; Rec."Best Price Quote")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Best Price Quote field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(MakeOrder)
        {

            trigger OnAfterAction()
            var
                ArchiveManagement: Codeunit ArchiveManagement;
            begin

                IndenNo := Rec."Indent No";
                Rec_PurchaseHeader.Reset();
                Rec_PurchaseHeader.SetRange("Document Type", Rec_PurchaseHeader."Document Type"::Quote);
                Rec_PurchaseHeader.SetRange("Indent No", IndenNo);
                if Rec_PurchaseHeader.FindSet() then
                    repeat
                        PurchHeaderArchive.Init();
                        PurchHeaderArchive.TransferFields(Rec_PurchaseHeader);
                        PurchHeaderArchive."Archived By" := UserId;
                        PurchHeaderArchive."Date Archived" := WorkDate();
                        PurchHeaderArchive."Time Archived" := Time;
                        PurchHeaderArchive."Version No." :=
                            ArchiveManagement.GetNextVersionNo(
                                Database::"Purchase Header", Rec_PurchaseHeader."Document Type".AsInteger(), Rec_PurchaseHeader."No.", Rec_PurchaseHeader."Doc. No. Occurrence");
                        PurchHeaderArchive.Insert();
                        Rec_PurchaseHeader.Modify();
                        purchlinetoarc(PurchLine, Rec_PurchaseHeader);

                    until Rec_PurchaseHeader.Next() = 0;
                Rec_PurchaseHeader.DeleteAll();
            end;

        }
        addafter(AttachAsPDF)
        {
            action("Quote Comparison")
            {
                Caption = 'Purchase Quote Comparison';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                ShortcutKey = 'Ctrl+C';
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Purchase Quote Comparison action.';

                trigger OnAction()
                var
                begin
                    PurchLine.Reset();
                    PurchLine.SetRange("Indent No.", Rec."Indent No");
                    if PurchLine.FindFirst() then
                        Report.RunModal(70001, true, false, PurchLine);
                    //    test.SetTableView(PurchLine);
                    //    test.Run();
                    // Report.Run(70001,false,FALSE,PurchLine);

                end;
            }
        }
    }
    local procedure StoreDeferrals(DeferralDocType: Integer; DocType: Integer; DocNo: Code[20]; LineNo: Integer; DocNoOccurrence: Integer; VersionNo: Integer)
    var
        DeferralHeader: Record "Deferral Header";
        DeferralHeaderArchive: Record "Deferral Header Archive";
        DeferralLine: Record "Deferral Line";
        DeferralLineArchive: Record "Deferral Line Archive";
    begin
        if DeferralHeader.Get(DeferralDocType, '', '', DocType, DocNo, LineNo) then begin
            DeferralHeaderArchive.Init();
            DeferralHeaderArchive.TransferFields(DeferralHeader);
            DeferralHeaderArchive."Doc. No. Occurrence" := DocNoOccurrence;
            DeferralHeaderArchive."Version No." := VersionNo;
            DeferralHeaderArchive.Insert();

            DeferralLine.SetRange("Deferral Doc. Type", DeferralDocType);
            DeferralLine.SetRange("Gen. Jnl. Template Name", '');
            DeferralLine.SetRange("Gen. Jnl. Batch Name", '');
            DeferralLine.SetRange("Document Type", DocType);
            DeferralLine.SetRange("Document No.", DocNo);
            DeferralLine.SetRange("Line No.", LineNo);
            if DeferralLine.FindSet() then
                repeat
                    DeferralLineArchive.Init();
                    DeferralLineArchive.TransferFields(DeferralLine);
                    DeferralLineArchive."Doc. No. Occurrence" := DocNoOccurrence;
                    DeferralLineArchive."Version No." := VersionNo;
                    DeferralLineArchive.Insert();
                until DeferralLine.Next() = 0;
        end;
    end;

    local procedure purchlinetoarc(var PurchLine1: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        PurchLineArchive1: Record "Purchase Line Archive";

    begin
        PurchLine1.SetRange(PurchLine1."Document Type", PurchHeader."Document Type");
        PurchLine1.SetRange(PurchLine1."Document No.", PurchHeader."No.");
        PurchLine1.SetRange(PurchLine1."Indent No.", PurchHeader."Indent No");
        if PurchLine1.FindSet() then
            repeat
                with PurchLineArchive1 do begin
                    PurchLineArchive1.Init();
                    PurchLineArchive1.TransferFields(PurchLine1);
                    PurchLineArchive1."Doc. No. Occurrence" := PurchHeader."Doc. No. Occurrence";
                    PurchLineArchive1."Version No." := PurchHeaderArchive."Version No.";
                    RecordLinkManagement.CopyLinks(PurchLine1, PurchLineArchive);
                    PurchLineArchive1.Insert();
                    PurchLineArchive1.Modify()
                end;
                if PurchLine1."Deferral Code" <> '' then
                    StoreDeferrals(
                        "Deferral Document Type"::Purchase.AsInteger(), PurchLine1."Document Type".AsInteger(),
                        PurchLine1."Document No.", PurchLine1."Line No.", PurchHeader."Doc. No. Occurrence", PurchHeaderArchive."Version No.");
            until PurchLine1.Next() = 0;
    end;

    var
        Rec_PurchaseHeader: Record "Purchase Header";

        PurchHeaderArchive: Record "Purchase Header Archive";
        PurchLine: Record "Purchase Line";
        PurchLineArchive: Record "Purchase Line Archive";
        // noser: Codeunit NoSeriesManagement;
        RecordLinkManagement: Codeunit "Record Link Management";
        IndenNo: Code[20];

}