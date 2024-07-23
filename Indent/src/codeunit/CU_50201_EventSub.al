codeunit 50201 EventSub
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Page, Page::"Released Indent Header", 'OnAfterActionEvent', "P&ost", false, false)]
    local procedure ApproveGenJnlLine(var Rec: Record "Indent Header")
    var
        IndentLine: Record "Indent Line";
    begin
        IndentLine.Reset();
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.FindFirst() then
            repeat
                IndentLine."Issued Quantity" += IndentLine."Quantity To Issue";
                IndentLine."Remaining Qty" := IndentLine.Quantity - IndentLine."Issued Quantity";
                IndentLine."Quantity To Issue" := 0;
                IndentLine.Modify();
            until IndentLine.Next() = 0;

        IndentLine.Reset();
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.FindSet() then begin
            IndentLine.CalcSums(Quantity, "Issued Quantity");
            if IndentLine.Quantity = IndentLine."Issued Quantity" then begin
                Rec."Indent Closed" := true;
                Rec.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 80053, 'OnBeforeValidateEvent', "Create PO", false, false)]
    local procedure OnBeforeValidateEvent(var Rec: Record "Indent Vendor")
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            if not UserSetup."Purchase Price" then
                Error('You are not Authorised.');

    end;
}