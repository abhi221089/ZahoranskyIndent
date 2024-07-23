page 80204 "Posted Material Indent"
{
    Caption = 'Purchase Request Order';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    UsageCategory = Documents;
    ApplicationArea = All;
    RefreshOnActivate = true;
    SourceTable = "Indent Header";
    SourceTableView = where(Posted = const(true),
                            RFQ = const(false)
                            );


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Send To"; Rec."Send To")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Send To field.';
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Preferred Vendor"; Rec."Preferred Vendor")
                {
                    //ApplicationArea= all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Preferred Vendor field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }

                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                }
            }
            part(PostedIndentLine; "Posted Indent Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), Posted = const(true);
            }
            group("Indent Information")
            {
                Caption = 'User Information';
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
            }
        }
        area(FactBoxes)
        {
            // part("Attached Documents"; "Document Attachment Factbox")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Attachments';
            //     SubPageLink = "Table ID" = CONST(80001),
            //                   "No." = FIELD("No.");
            //                  // "Document Type" = FIELD("Document Type");
            // }
            // part(IncomingDocAttachFactBox; 193)
            // {
            //     ApplicationArea = all;
            //     ShowFilter = false;
            // }
            // systempart(Links; Links)
            // {

            //     Visible = false;
            // }
            // systempart(Notes; Notes)
            // {
            //     Visible = false;
            // }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Indent")
            {
                Caption = '&Indent';
                action(Reopen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Visible = false;
                    ToolTip = 'Executes the Reopen action.';
                }
            }
        }
        area(Processing)
        {
            action("&Shot Closed")
            {
                Caption = '&Shot Closed';
                Visible = false;
                ToolTip = 'Executes the &Shot Closed action.';

                trigger OnAction()
                var
                    IndentLine: Record "Indent Line";
                begin
                    ShortCloseStatus := false;
                    Rec.TestField(Status, Rec.Status::Released);
                    if not UserSetup.Get(UserId) then
                        Error(T001, UserId, Rec."No.");
                    IndentLine.Reset();
                    IndentLine.SetRange(Type, Rec.Type);
                    IndentLine.SetRange("Document No.", Rec."No.");
                    if IndentLine.Find('-') then
                        repeat
                            if ((IndentLine."Outstanding Quantity" < IndentLine."Approved Quantity") and (IndentLine."Outstanding Quantity" <> 0)) then begin
                                IndentLine."Short Closed" := true;
                                IndentLine.Close := true;
                                IndentLine.Modify();
                                ShortCloseStatus := true
                            end;
                        until IndentLine.Next() = 0;
                    if ShortCloseStatus = true then begin
                        Rec.Status := Rec.Status::"Short Closed";
                        Rec.Modify();
                    end;

                end;
            }
            action("&Rejected")
            {
                Caption = '&Rejected';
                Visible = false;
                ToolTip = 'Executes the &Rejected action.';

                trigger OnAction()
                var
                    IndentLine: Record "Indent Line";
                    T001: Label 'Cannot Reject %1, because Indent Already in User Item No %2.';
                begin

                    Rec.TestField(Status, Rec.Status::Released);
                    if not UserSetup.Get(UserId) then
                        Error(T001, UserId, Rec."No.");
                    IndentLine.Reset();
                    IndentLine.SetRange(Type, Rec.Type);
                    IndentLine.SetRange("Document No.", Rec."No.");
                    if IndentLine.Find('-') then
                        repeat
                            IndentLine.CalcFields(IndentLine."Quantity on PO");
                            if IndentLine."Quantity on PO" <> 0 then
                                Error(T001, IndentLine."Document No.", IndentLine."No.");
                        until IndentLine.Next() = 0;
                    IndentLine.Reset();
                    IndentLine.SetRange(Type, Rec.Type);
                    IndentLine.SetRange("Document No.", Rec."No.");
                    if IndentLine.Find('-') then
                        repeat
                            if IndentLine."Approved Quantity" = IndentLine."Outstanding Quantity" then begin
                                IndentLine.Rejected := true;
                                IndentLine.Close := true;
                                Rec."Rejected By" := UserId;
                                Rec."Rejected Date" := WorkDate();
                                IndentLine.Modify();
                            end;
                        until IndentLine.Next() = 0;
                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify();

                end;
            }
            action("Generate Purchase Order")
            {
                Caption = 'Generate Purchase Order';
                Image = Process;
                Promoted = true;
                ShortcutKey = 'Ctrl+Q';
                ToolTip = 'Executes the Generate Purchase Order action.';

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to create Purchase Order ?') then
                        exit;

                    IndentLine.Reset();
                    IndentLine.SetRange("Document No.", Rec."No.");
                    if IndentLine.FindSet() then
                        repeat
                            IndentVendor.Reset();
                            IndentVendor.SetRange("Indent No.", IndentLine."Document No.");
                            IndentVendor.SetRange("Indent Line No.", IndentLine."Line No.");
                            IndentVendor.SetRange("Create PO", true);
                            if not IndentVendor.FindFirst() then
                                Error('There is no line to create purchase order against the Indent No %1, Line No %2', IndentLine."Document No.", IndentLine."Line No.");
                        until IndentLine.Next() = 0;

                    GenerateQuote();

                end;
            }
            action("Quote Comparison")
            {
                Caption = 'Purchase Quote Comparison';
                Image = "Report";
                Promoted = true;
                ShortcutKey = 'Ctrl+C';
                Visible = false;
                ToolTip = 'Executes the Purchase Quote Comparison action.';

                trigger OnAction()
                begin
                    PurchLine.Reset();
                    PurchLine.SetRange("Indent No.", Rec."No.");
                    if PurchLine.FindFirst() then
                        Report.RunModal(70001, true, false, PurchLine);
                end;
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                Visible = false;
                action(IncomingDocCard)
                {
                    Caption = 'View Incoming Document';
                    Image = ViewOrder;
                    ToolTip = 'Executes the View Incoming Document action.';


                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin

                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = tabledata 130 = R;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;

                    Visible = false;
                    ToolTip = 'Executes the Select Incoming Document action.';

                    trigger OnAction()
                    begin
                        // rec.VALIDATE(rec."Incoming Document Entry No",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No"));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Image = Attach;

                    Visible = false;
                    ToolTip = 'Executes the Create Incoming Document from File action.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin

                        IncomingDocumentAttachment.NewAttachmentFromIndentDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    Caption = 'Remove Incoming Document';
                    Image = RemoveLine;

                    Visible = false;
                    ToolTip = 'Executes the Remove Incoming Document action.';

                    trigger OnAction()
                    begin
                        // rec."Incoming Document Entry No." := 0;
                    end;
                }
            }
        }
    }

    var
        IndentLine: Record "Indent Line";
        IndentVendor: Record "Indent Vendor";
        PurchLine: Record "Purchase Line";
        UserSetup: Record "User Setup";
        ShortCloseStatus: Boolean;
        T001: Label 'User ID %1 not permission for short close the Purchase Order %2.';

    procedure ApprovalDisplay()
    begin
    end;

    procedure RejectedEntryTrack(): Boolean
    begin
    end;

    procedure ApprovalEntryTrack(): Boolean
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ApprovalDisplay();
    end;

    procedure GenerateQuote()
    var
        IndentLine: Record "Indent Line";
        IndentVendor: Record "Indent Vendor";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VendorCode: Code[50];
        LineNo: Integer;
    begin
        PurchSetup.Get();
        IndentVendor.Reset();
        IndentVendor.SetCurrentKey("Indent No.", "Vendor Code");
        IndentVendor.SetRange("Indent No.", Rec."No.");
        IndentVendor.SetFilter("Vendor Code", '<>%1', '');
        IndentVendor.SetFilter(Cost, '<>%1', 0);
        IndentVendor.SetRange(Order, false);
        if IndentVendor.IsEmpty then
            Error('Indent Vendor record was not valid/inserted for generating Purchase Order from Indent %1', Rec."No.");

        IndentVendor.Reset();
        IndentVendor.SetCurrentKey("Vendor Code");
        IndentVendor.SetRange("Indent No.", Rec."No.");
        IndentVendor.SetRange("Create PO", true);
        IndentVendor.SetRange(Order, false);
        if IndentVendor.FindSet() then
            repeat
                if (VendorCode <> IndentVendor."Vendor Code") then begin
                    //Create Purchase Header
                    Clear(PurchaseHeader);
                    Clear(PurchaseLine);

                    PurchaseHeader.Init();
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;

                    Clear(NoSeriesMgt);
                    PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PurchSetup."Order Nos.", Today, true);
                    PurchaseHeader.Validate("Buy-from Vendor No.", IndentVendor."Vendor Code");
                    PurchaseHeader.Validate("Posting Date", Today);
                    PurchaseHeader.Validate("Order Date", Today);
                    if Rec."Quality Order" then
                        PurchaseHeader.Validate("Location Code", 'QC')
                    else
                        PurchaseHeader.Validate("Location Code", 'STORE');
                    PurchaseHeader."Indent No" := Rec."No.";
                    PurchaseHeader."Indent Type" := Rec."Indent Type";
                    PurchaseHeader."Requested Date" := Rec."Required Date";
                    PurchaseHeader.Insert();
                    // IndentLine.RESET;
                    // IndentLine.SETRANGE("No.", rec."No.");
                    // IF IndentLine.FINDFIRST THEN BEGIN
                    //     PurchaseHeader.VALIDATE("Location Code", IndentLine."Location Code");
                    // END;
                    PurchaseHeader.Validate("Dimension Set ID", Rec."Dimension Set ID");
                    //  PurchaseHeader.VALIDATE("Shortcut Dimension 1 Code", rec."Shortcut Dimension 1 Code");
                    //  PurchaseHeader.VALIDATE("Shortcut Dimension 2 Code", rec."Shortcut Dimension 2 Code");
                    PurchaseHeader.Modify();

                    //Create Purchase Lines
                    VendorCode := IndentVendor."Vendor Code";
                    IndentLine.Get(IndentVendor."Indent No.", IndentVendor."Indent Line No.");
                    PurchaseLine.Init();
                    PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                    PurchaseLine."Document No." := PurchaseHeader."No.";
                    PurchaseLine."Line No." := 10000;
                    PurchaseLine.Insert();
                    if IndentLine.Type = IndentLine.Type::GL then
                        PurchaseLine.Validate(Type, PurchaseLine.Type::"G/L Account");
                    if IndentLine.Type = IndentLine.Type::"Fixed Asset" then
                        PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
                    PurchaseLine.Validate(Type, PurchaseLine.Type::"Fixed Asset");
                    if IndentLine.Type in [IndentLine.Type::Item, IndentLine.Type::"Non-Inventory Item", IndentLine.Type::"Service Item"] then
                        PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
                    PurchaseLine.Validate("No.", IndentLine."No.");
                    PurchaseLine.Validate(Quantity, IndentLine."Indent Quantity");
                    PurchaseLine.Validate("Direct Unit Cost", IndentVendor.Cost);
                    PurchaseLine.Validate("Indent No.", IndentLine."Document No.");
                    PurchaseLine.Validate("Indent Line No", IndentLine."Line No.");
                    PurchaseLine."Indent Type" := IndentLine."Indent Type";
                    PurchaseLine."Indent Date" := IndentLine."Posting Date";
                    PurchaseLine."Order Date" := Today();

                    //   PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", IndentLine."Shortcut Dimension 2 Code");
                    PurchaseHeader.Validate("Dimension Set ID", Rec."Dimension Set ID");
                    PurchaseLine.Modify();
                    IndentLine."PO No." := PurchaseLine."Document No.";
                    IndentLine."PO Line No." := PurchaseLine."Line No.";
                    IndentLine.Modify();
                    Message('Purchase Order %1 generated successfully.', PurchaseHeader."No.");
                end
                else begin
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                    if PurchaseLine.FindLast() then
                        LineNo := PurchaseLine."Line No.";
                    //Create Purchase Lines
                    VendorCode := IndentVendor."Vendor Code";
                    PurchaseLine.Init();
                    IndentLine.Get(IndentVendor."Indent No.", IndentVendor."Indent Line No.");
                    PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                    PurchaseLine."Document No." := PurchaseHeader."No.";
                    PurchaseLine."Line No." := LineNo + 10000;
                    PurchaseLine.Insert();
                    if IndentLine.Type in [IndentLine.Type::Item, IndentLine.Type::"Non-Inventory Item", IndentLine.Type::"Service Item"] then
                        PurchaseLine.Validate(Type, 2);
                    if IndentLine.Type = IndentLine.Type::GL then
                        PurchaseLine.Validate(Type, 1);
                    if IndentLine.Type = IndentLine.Type::"Fixed Asset" then
                        PurchaseLine.Validate(Type, PurchaseLine.Type::"Fixed Asset");
                    PurchaseLine.Validate("No.", IndentLine."No.");
                    PurchaseLine.Validate(Quantity, IndentLine."Indent Quantity");
                    PurchaseLine.Validate("Direct Unit Cost", IndentVendor.Cost);
                    PurchaseLine.Validate("Indent No.", IndentLine."Document No.");
                    PurchaseLine.Validate("Indent Line No", IndentLine."Line No.");
                    PurchaseLine."Indent Type" := IndentLine."Indent Type";
                    //   PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", IndentLine."Shortcut Dimension 1 Code");
                    //  PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", IndentLine."Shortcut Dimension 2 Code");
                    PurchaseHeader.Validate("Dimension Set ID", Rec."Dimension Set ID");
                    PurchaseLine."Indent Date" := IndentLine."Posting Date";
                    PurchaseLine.Modify();
                    IndentLine."PO No." := PurchaseLine."Document No.";
                    IndentLine."PO Line No." := PurchaseLine."Line No.";
                    IndentLine.Modify();
                end;
                IndentVendor.Order := true;
                IndentVendor.Modify();
            until IndentVendor.Next() = 0
        else
            Message('Purchase Order is already created.');
    end;
}

