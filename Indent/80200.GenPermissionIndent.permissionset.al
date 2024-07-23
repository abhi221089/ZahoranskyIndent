permissionset 80200 GenPermissionIndent
{
    Assignable = true;
    Permissions = tabledata "Indent Header" = RIMD,
        tabledata "Indent Line" = RIMD,
        tabledata "Indent Vendor" = RIMD,
        table "Indent Header" = X,
        table "Indent Line" = X,
        table "Indent Vendor" = X,
        report "Quote Comparison" = X,
        codeunit ApprovalCodeunit = X,
        codeunit EventSub = X,
        page "Closed Indent Header" = X,
        page "Closed Indent List" = X,
        page "Closed Indent Subform" = X,
        page "Indent Header" = X,
        page "Indent List" = X,
        page "Indent Subform" = X,
        page "Indent Vendor" = X,
        page "Open Purchase Request Header" = X,
        page "Open Purchase Request List" = X,
        page "Open Purchase Request Subform" = X,
        page "Posted Indent Subform" = X,
        page "Posted Material Indent" = X,
        page "Posted Material Indent List" = X,
        page "Released Indent Header" = X,
        page "Released Indent List" = X,
        page "Released Indent Subform" = X;
}