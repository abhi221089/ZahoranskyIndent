page 80201 "Indent Header"
{
    Caption = 'Inventory Order';
    SourceTable = "Indent Header";
    ApplicationArea = All;

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
                    ToolTip = 'Specifies the value of the Type field.';

                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                    Editable = Edit;
                    ToolTip = 'Specifies the value of the Required Date field.';
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
                field("Quality Order"; Rec."Quality Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quality Order field.';
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
            part(IndentLine; "Indent Subform")
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
            group(RequestApproval)
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    Promoted = true;
                    Ellipsis = true;
                    ApplicationArea = Basic, Suite;
                    Enabled = not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval to change the record.';
                    trigger OnAction()
                    var
                        AllcodeEvent: Codeunit ApprovalCodeunit;
                    begin
                        if Rec."Requisition Type" = Rec."Requisition Type"::" " then
                            Error('Requisition type can not be blank.');
                        if Rec."Indent Type" = Rec."Indent Type"::" " then
                            Error('Indent type can not be blank.');
                        Rec.TestField("Location Code");
                        if Rec."Indent Type" = Rec."Indent Type"::Transfer then
                            Rec.TestField("Transfer To");

                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");
                        Rec.TestField("Shortcut Dimension 3 Code");
                        Rec.TestField("Shortcut Dimension 4 Code");
                        Rec.TestField("Shortcut Dimension 6 Code");

                        if AllcodeEvent.CheckItemAmendApprovalsWorkflowEnabled(Rec) then
                            AllcodeEvent.RunWorkflowOnSendItemAmendForApprovalCode(Rec);

                    end;
                }
                action(CancelApprovalRequest)
                {
                    Promoted = true;
                    Ellipsis = true;
                    ApplicationArea = Basic, Suite;
                    Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    trigger OnAction()
                    var
                        AllcodeEvent: Codeunit ApprovalCodeunit;
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        AllcodeEvent.RunWorkflowOnCancelItemAmendApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(Rec.RecordId);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    var
                        ApprovalEntry2: Record "Approval Entry";
                        RecIndentREQ: Record "Indent Header";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        ApprovalEntry2.SetRange("Document No.", Rec."No.");
                        ApprovalEntry2.SetCurrentKey("Sequence No.");
                        if ApprovalEntry2.FindLast() then
                            if ApprovalEntry2."Approver ID" = UserId then begin
                                RecIndentREQ.SetRange(RecIndentREQ."No.", Rec."No.");
                                if RecIndentREQ.FindFirst() then begin
                                    RecIndentREQ.Validate(Status, RecIndentREQ.Status::Released);
                                    RecIndentREQ.Modify();
                                end;
                            end;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //PromotedOnly = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    var
                        IndentHeader: Record "Indent Header";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        IndentHeader.SetRange("No.", Rec."No.");
                        if IndentHeader.FindFirst() then begin
                            IndentHeader.Status := IndentHeader.Status::Open;
                            IndentHeader.Modify();
                        end;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortcutKey = 'Ctrl+F9';
                    Visible = false;
                    ToolTip = 'Executes the Re&lease action.';
                    trigger OnAction()
                    var
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
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = 'F9';
                    Visible = false;
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction()
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Error('Kindly release the indent first');

                        IndentLine.Reset();
                        IndentLine.SetRange("Document No.", Rec."No.");
                        if IndentLine.FindFirst() then
                            repeat
                                IndentLine.TestField(IndentLine."No.");
                            until IndentLine.Next() = 0;

                        PostIndent();
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

    protected var
        EventFilter: Text;

    var
        IndentLine: Record "Indent Line";
        IndentLinePage: Record "Indent Line";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        Edit: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        if GuiAllowed() then
            OnAfterGetCurrRecordFunc();

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    trigger OnInit()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        if not GuiAllowed then
            exit;
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode() + '|' +
          WorkflowEventHandling.RunWorkflowOnItemChangedCode();

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(Database::"Indent Header", EventFilter);
    end;


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

    local procedure OnGetRecord()
    begin
        xRec := Rec;
    end;

    local procedure OnAfterGetCurrRecordFunc()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId());
    end;

}

