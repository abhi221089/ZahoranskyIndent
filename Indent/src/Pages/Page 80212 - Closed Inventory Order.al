page 80212 "Closed Indent Header"
{
    SourceTable = "Indent Header";
    Caption = 'Posted Inventory Order';
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

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
                    Editable = Edit;
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
                field("Transfer To"; Rec."Transfer To")
                {
                    ApplicationArea = All;
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
            part(IndentLine; "Closed Indent Subform")
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


        }
        area(Processing)
        {


        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Released then
            Edit := true;
    end;

    var
        IndentLine: Record "Indent Line";
        Edit: Boolean;
        LineNo: Integer;

    procedure PostIndent()
    var
        IndentLine: Record "Indent Line";
    begin
        if not Confirm('Do you want to post Indent?', true) then
            exit;
        Rec.Posted := true;
        Rec.Modify();
        IndentLine.Reset();
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.FindFirst() then
            repeat
                IndentLine.Posted := true;
                IndentLine.Modify();
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
                    ItemJournalLine.Validate("Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
                    ItemJournalLine.Modify();
                end;
            until IndentLine.Next() = 0;

        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'Item');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'MR_POST');
        if ItemJournalLine.FindSet() then Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);
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
                    ItemJournalLine.Validate("Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
                    ItemJournalLine.Validate("New Shortcut Dimension 1 Code", IndentHeader."Shortcut Dimension 1 Code");
                    ItemJournalLine.Validate("New Shortcut Dimension 2 Code", IndentHeader."Shortcut Dimension 2 Code");
                    ItemJournalLine.Modify();
                end;
            until IndentLine.Next() = 0;

        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'Transfer');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'MR_POST');
        if ItemJournalLine.FindSet() then Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);
    end;
}

