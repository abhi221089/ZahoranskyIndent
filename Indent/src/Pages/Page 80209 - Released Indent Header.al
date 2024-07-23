page 80209 "Released Indent Header"
{
    SourceTable = "Indent Header";
    Caption = 'Released Inventory Order';
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                    Editable = Edit;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Send To"; Rec."Send To")
                {
                    ApplicationArea = All;
                    Caption = 'Required For';
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the Required For field.';
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                field("Indent Type"; Rec."Indent Type")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the Indent Type field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }

                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                }
                field("Transfer To"; Rec."Transfer To")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transfer To field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Estimated Price Line Amount"; Rec."Estimated Price Line Amount")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Estimated Price Line Amount field.';
                }
                field("Short Received"; Rec."Short Received")
                {
                    Editable = Edit;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Short Received field.';

                    trigger OnValidate()
                    begin
                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        IndentLine.SetFilter("Return Quantity", '<>%1', 0);
                        if IndentLine.FindFirst() then begin
                            Rec."Short Received" := true;
                            Rec.Modify();
                        end;
                    end;
                }
                field("Preferred Vendor"; Rec."Preferred Vendor")
                {
                    //ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Preferred Vendor field.';
                }

            }
            part(IndentLine; "Released Indent Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                SubPageView = sorting("Document No.", "Line No.");
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
            //   part("Attached Documents"; "Document Attachment Factbox")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Attachments';
            //     SubPageLink = "Table ID" = CONST(80001),
            //                   "No." = FIELD("No.");
            //                  // "Document Type" = FIELD("Document Type");
            // }
            // part(IncomingDocAttachFactBox; 193)
            // {
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

            group("F&unction")
            {
                Caption = 'F&unction';
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Visible = false;
                    ShortcutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action.';
                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Released;
                        Edit := false;
                        Rec.Modify();
                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        if IndentLine.FindFirst() then
                            repeat
                                IndentLine.Status := IndentLine.Status::Released;
                                IndentLine.Validate(Status);
                                IndentLine.Modify();
                            until IndentLine.Next() = 0;
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = true;
                    ToolTip = 'Executes the Re&open action.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Posted, false);
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.Status := Rec.Status::Open;
                        Edit := true;
                        Rec.Modify();

                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        if IndentLine.FindFirst() then begin
                            IndentLine.Status := IndentLine.Status::Open;
                            IndentLine.Validate(Status);
                            IndentLinePage.Validate(Status);
                            IndentLine.Modify();
                        end;
                    end;
                }
            }
        }
        area(Processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                // Visible = false;
                action("C&reate PR")
                {
                    Caption = 'Create PR';
                    Image = Create;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = 'F10';
                    ToolTip = 'Executes the Create PR action.';
                    trigger OnAction()
                    begin
                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        IndentLine.SetFilter(IndentLine."Indent Quantity", '>%1', 0);
                        if not IndentLine.FindFirst() then
                            Error('There is nothing to create PR.');

                        if not Rec.Posted then begin
                            PostIndent();
                            Message('PR is created.');
                        end else
                            Error('Indent is already created.')

                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action.';
                    trigger OnAction()
                    begin
                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        IndentLine.SetFilter(IndentLine."Quantity To Issue", '>%1', 0);
                        if not IndentLine.FindFirst() then
                            Error('There is nothing to Post.');

                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        if IndentLine.FindFirst() then
                            repeat
                                IndentLine.TestField(IndentLine."No.");
                            // if IndentLine."Quantity To Issue" <= 0 then
                            //     Error('Quantity to issue must have a value in it.');
                            // if IndentLine."Quantity To Issue" > 0 then
                            //     IndentLine.TestField(IndentLine."Bin Code");
                            until IndentLine.Next() = 0;

                        if Rec."Indent Type" = Rec."Indent Type"::Issue then begin
                            if not Confirm('Are you sure you want to Issue the Quantity?') then
                                Error('');
                            InsertItemJournal(Rec);

                        end;

                        if Rec."Indent Type" = Rec."Indent Type"::Transfer then begin
                            if not Confirm('Are you sure you want to Transfer the Quantity?') then
                                Error('');
                            InsertItemReclassJournal(Rec);
                        end;
                    end;
                }
                action("Close Order")
                {
                    Caption = 'Close Order';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Close Order action.';
                    trigger OnAction()
                    begin
                        Rec.TestField(Remarks);

                        if not Confirm('Do you want to closed the order?') then begin
                            IndentLine.Reset();
                            IndentLine.SetRange("Document No.", Rec."No.");
                            if IndentLine.FindFirst() then
                                repeat
                                    IndentLine.TestField(IndentLine."No.");
                                until IndentLine.Next() = 0;
                            Rec."Indent Closed" := true;
                            Rec.Modify();
                            Message('Order is closed.');
                        end else
                            exit;

                    end;
                }
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
                    ApplicationArea = All;
                    ToolTip = 'Executes the Select Incoming Document action.';
                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate(Rec."Incoming Document Entry No", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No", Rec.RecordId));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Visible = false;
                    Image = Attach;
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
                    ApplicationArea = All;
                    ToolTip = 'Executes the Remove Incoming Document action.';

                    trigger OnAction()
                    begin
                        Rec."Incoming Document Entry No" := 0;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Released then
            Edit := true;
    end;

    var
        IndentLine: Record "Indent Line";
        IndentLinePage: Record "Indent Line";
        Edit: Boolean;
        LineNo: Integer;

    procedure PostIndent()
    var
        IndentLine: Record "Indent Line";
    begin
        if not Confirm('Do you want to Create PR?', true) then
            exit;
        Rec.Posted := true;
        Rec.Modify();
        IndentLine.Reset();
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.FindFirst() then
            repeat
                if IndentLine."Indent Quantity" > 0 then begin
                    IndentLine.Posted := true;
                    IndentLine.Modify();
                end;
            until IndentLine.Next() = 0;
    end;

    procedure RejectedEntryTrack(): Boolean
    begin
    end;

    procedure ApprovalEntryTrack(): Boolean
    begin
    end;

    procedure GetIndentLines()
    begin
        IndentLine.Reset();
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.FindFirst() then;
    end;

    procedure ApprovalProcess(): Boolean
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
    end;

    procedure InsertItemJournal(IndentHeader: Record "Indent Header")
    var
        IndentLine: Record "Indent Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine1: Record "Item Journal Line";
    begin
        ItemJournalLine1.Reset();
        ItemJournalLine1.SetRange("Journal Template Name", 'Item');
        ItemJournalLine1.SetRange("Journal Batch Name", 'MR_POST');
        ItemJournalLine1.SetRange("Document No.", IndentHeader."No.");
        ItemJournalLine.DeleteAll();

        IndentLine.SetRange("Document No.", Rec."No.");
        IndentLine.SetRange("Indent Type", IndentLine."Indent Type"::Issue);
        if IndentLine.FindSet() then
            repeat
                if IndentLine."Quantity To Issue" > 0 then begin
                    ItemJournalLine1.Reset();
                    ItemJournalLine1.SetRange("Journal Template Name", 'Item');
                    ItemJournalLine1.SetRange("Journal Batch Name", 'MR_POST');
                    if ItemJournalLine1.FindLast() then
                        LineNo := ItemJournalLine1."Line No." + 10000
                    else
                        LineNo := 10000;

                    ItemJournalLine.Init();
                    ItemJournalLine.Validate("Journal Template Name", 'Item');
                    ItemJournalLine.Validate("Journal Batch Name", 'MR_POST');
                    ItemJournalLine."Line No." := LineNo;
                    ItemJournalLine.Insert();
                    ItemJournalLine."Document No." := IndentHeader."No.";
                    ItemJournalLine.Validate("Posting Date", Today);
                    ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                    ItemJournalLine.Validate("Item No.", IndentLine."No.");
                    ItemJournalLine.Validate("Location Code", IndentHeader."Location Code");
                    ItemJournalLine.Validate("Bin Code", IndentLine."Bin Code");
                    ItemJournalLine.Validate(Quantity, IndentLine."Quantity To Issue");
                    ItemJournalLine.Validate("Dimension Set ID", IndentHeader."Dimension Set ID");
                    ItemJournalLine.Validate("Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
                    ItemJournalLine.Modify();
                end;
            until IndentLine.Next() = 0;
        Commit();

        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'Item');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'MR_POST');
        if ItemJournalLine.FindSet() then
            Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);

    end;

    procedure InsertItemReclassJournal(IndentHeader: Record "Indent Header")
    var
        IndentLine: Record "Indent Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLine1: Record "Item Journal Line";
    begin
        IndentLine.SetRange("Document No.", Rec."No.");
        IndentLine.SetRange("Indent Type", IndentLine."Indent Type"::Transfer);
        if IndentLine.FindSet() then
            repeat
                if IndentLine."Quantity To Issue" > 0 then begin
                    ItemJournalLine1.Reset();
                    ItemJournalLine1.SetRange("Journal Template Name", 'Transfer');
                    ItemJournalLine1.SetRange("Journal Batch Name", 'MR_POST');
                    if ItemJournalLine1.FindLast() then
                        LineNo := ItemJournalLine1."Line No." + 10000
                    else
                        LineNo := 10000;

                    ItemJournalLine.Init();
                    ItemJournalLine.Validate("Journal Template Name", 'Transfer');
                    ItemJournalLine.Validate("Journal Batch Name", 'MR_POST');
                    ItemJournalLine."Line No." := LineNo;
                    ItemJournalLine.Insert();
                    ItemJournalLine."Document No." := IndentHeader."No.";
                    ItemJournalLine.Validate("Posting Date", Today);
                    ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::Transfer);
                    ItemJournalLine.Validate("Item No.", IndentLine."No.");
                    ItemJournalLine.Validate("Location Code", IndentHeader."Location Code");
                    ItemJournalLine.Validate("Bin Code", IndentLine."Bin Code");
                    ItemJournalLine.Validate(Quantity, IndentLine."Quantity To Issue");
                    ItemJournalLine.Validate("New Location Code", IndentHeader."Transfer To");
                    ItemJournalLine.Validate("Dimension Set ID", IndentHeader."Dimension Set ID");
                    ItemJournalLine.Validate("New Dimension Set ID", IndentHeader."Dimension Set ID");
                    ItemJournalLine.Validate("Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
                    ItemJournalLine.Validate("New Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("New Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
                    ItemJournalLine.Modify();
                end;
            until IndentLine.Next() = 0;

        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'Transfer');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'MR_POST');
        //ItemJournalLine.SetRange("Document No.",);
        if ItemJournalLine.FindSet() then
            Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);
    end;
}

