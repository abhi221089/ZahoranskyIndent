pageextension 80201 vendoercaedext extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Balance Due (LCY)")
        {
            field("Prefered Vendor FA"; Rec."Prefered Vendor FA")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prefered Vendor FA field.';
            }
        }
    }

    // actions
    // {
    //     modify(SendApprovalRequest)
    //     {
    //         trigger OnAfterAction()
    //         begin
    //             CompanyInfoRec.Get();
    //             if CompanyInfoRec."Vendor Approval" then begin
    //                 Rec.Status := Rec.Status::Pending;
    //                 Rec.Blocked := Rec.Blocked::All;
    //                 Rec.Modify();
    //             end;
    //         end;
    //     }
    //     modify(Approve)
    //     {
    //         trigger OnAfterAction()
    //         begin
    //             CompanyInfoRec.Get();
    //             if CompanyInfoRec."Vendor Approval" then begin
    //                 Rec.Status := Rec.Status::Approved;
    //                 Rec.Blocked := Rec.Blocked::" ";
    //                 Rec.Modify();
    //             end;
    //         end;
    //     }
    //     addafter(CancelApprovalRequest)
    //     {
    //         action(Reopen)
    //         {
    //             Caption = 'Reopen';
    //             ApplicationArea = All;
    //             Promoted = true;
    //             Image = Category;
    //             PromotedCategory = Category4;
    //             trigger OnAction()
    //             var
    //                 Text001Lbl: Label 'Do you want to Reopen Vendor No. %1 ?';
    //                 Text002Lbl: Label 'Vendor No. %1 has been Reopened.';
    //             begin
    //                 CompanyInfoRec.Get();
    //                 if CompanyInfoRec."Vendor Approval" then begin
    //                     IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
    //                         Rec.Status := Rec.Status::Open;
    //                         Rec.Blocked := Rec.Blocked::All;
    //                         Rec.Modify();
    //                         Message(Text002Lbl, Rec."No.");
    //                         CurrPage.Update();
    //                     end;
    //                 end;
    //             end;
    //         }
    //     }
    // }

    // trigger OnOpenPage()
    // begin
    //     if Rec.Status = Rec.Status::Open then
    //         CurrPage.Editable := true
    //     else
    //         CurrPage.Editable := false;


    // end;

    // trigger OnAfterGetRecord()
    // begin
    //     if Rec.Status = Rec.Status::Open then
    //         CurrPage.Editable := true
    //     else
    //         CurrPage.Editable := false;
    // end;

    // trigger OnAfterGetCurrRecord()
    // begin
    //     if Rec.Status = Rec.Status::Open then
    //         CurrPage.Editable := true
    //     else
    //         CurrPage.Editable := false;
    // end;

    // var
    //     CompanyInfoRec: Record "Company Information";
    //     PageEditBool: Boolean;
}
