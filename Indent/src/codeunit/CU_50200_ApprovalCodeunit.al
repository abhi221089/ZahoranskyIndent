codeunit 50200 ApprovalCodeunit
{
    EventSubscriberInstance = StaticAutomatic;
    //Workflow Scrap flow Start****.
    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        InwardChangeTXT1: Label 'A Indent Header record is changeds.';
        InwardDocApprReqCancelledEventDescTxt1: Label 'An approval request for a Indent Header is canceleds.';
        InwardDocSendForApprovalEventDescTxt1: Label 'Approval of a Indent Header is requesteds.';
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendInwardForApprovalCode1(), Database::"Indent Header", InwardDocSendForApprovalEventDescTxt1, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelInwardApprovalRequestCode1(), Database::"Indent Header", InwardDocApprReqCancelledEventDescTxt1, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnInwardChangedCode1(), Database::"Indent Header", InwardChangeTXT1, 0, true);
    end;

    procedure RunWorkflowOnSendInwardForApprovalCode1(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnInwardForApproval1'));
    end;

    procedure RunWorkflowOnCancelInwardApprovalRequestCode1(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelInwardApprovalRequest1'));
    end;

    procedure RunWorkflowOnInwardChangedCode1(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnInwardchangedCode1'));
    end;

    procedure RunWorkflowOnApproveApprovalRequestCode1(): Code[128]
    begin
        exit('RUNWORKFLOWONAPPROVEAPPROVALREQUEST1');
    end;


    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendInwardForApprovalCode1());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnInwardChangedCode1());
                end;
            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode():

                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendInwardForApprovalCode1());
            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode():

                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendInwardForApprovalCode1());
        end;
    end;

    procedure CheckItemAmendApprovalsWorkflowEnabled(var IndentHeader: Record "Indent Header"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'This record is not supported by related approval workflow.';
    begin
        if not WorkflowManagement.CanExecuteWorkflow(IndentHeader, RunWorkflowOnSendInwardForApprovalCode1()) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure RunWorkflowOnSendItemAmendForApprovalCode(var IndentHeader: Record "Indent Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendInwardForApprovalCode1(), IndentHeader);
    end;

    procedure RunWorkflowOnCancelItemAmendApprovalRequest(var IndentHeader: Record "Indent Header")
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelInwardApprovalRequestCode1(), IndentHeader);
    end;

    procedure RunWorkflowOnVendorAmendChanged(var Rec: Record "Indent Header"; var xRec: Record "Indent Header"; RunTrigger: Boolean)
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        if Format(xRec) <> Format(Rec) then
            WorkflowManagement.HandleEventWithxRec(RunWorkflowOnInwardChangedCode1(), Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        IndentHeader: Record "Indent Header";
    begin
        case RecRef.Number of
            Database::"Indent Header":
                begin
                    ApprovalEntryArgument.Init();
                    ApprovalEntryArgument."Table ID" := RecRef.Number;
                    ApprovalEntryArgument."Record ID to Approve" := RecRef.RecordId;
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Order;
                    ApprovalEntryArgument."Approval Code" := WorkflowStepInstance."Workflow Code";
                    ApprovalEntryArgument."Workflow Step Instance ID" := WorkflowStepInstance.ID;
                    RecRef.SetTable(IndentHeader);
                    ApprovalEntryArgument."Document No." := IndentHeader."No.";
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Order;
                    IndentHeader.Status := IndentHeader.Status::"Pending Approval";
                    IndentHeader.Modify();
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Requests to Approve", 'OnAfterActionEvent', 'Approve', false, false)]
    local procedure CreateItemRequest(var Rec: Record "Approval Entry")
    var
        ApprovalEntry2: Record "Approval Entry";
        RecIndentREQ: Record "Indent Header";
    begin
        ApprovalEntry2.SetRange("Document No.", Rec."Document No.");
        ApprovalEntry2.SetCurrentKey("Sequence No.");
        if ApprovalEntry2.FindLast() then
            if ApprovalEntry2."Approver ID" = UserId then begin
                RecIndentREQ.SetRange(RecIndentREQ."No.", Rec."Document No.");
                if RecIndentREQ.FindFirst() then begin
                    RecIndentREQ.Validate(Status, RecIndentREQ.Status::Released);
                    RecIndentREQ.Modify();
                end;
            end;

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    // procedure OnSetStatusToPendingApproval(var IsHandled: Boolean)
    // begin
    //     IsHandled := true;
    // end;

    [EventSubscriber(ObjectType::Page, Page::"Requests to Approve", 'OnAfterActionEvent', 'Reject', false, false)]
    local procedure UpdateStatus(var Rec: Record "Approval Entry")
    var
        IndentHeader: Record "Indent Header";
    begin
        IndentHeader.SetRange("No.", Rec."Document No.");
        if IndentHeader.FindFirst() then begin
            IndentHeader.Status := IndentHeader.Status::Open;
            IndentHeader.Modify();
        end;
    end;
}