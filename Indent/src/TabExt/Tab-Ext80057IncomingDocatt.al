
tableextension 80057 incomingDocext extends "Incoming Document Attachment"
{
    fields
    {
        // Add changes to table fields here
    }
    procedure NewAttachmentFromIndentDocument(IndentHeader: Record "Indent Header")
    begin
        //rec.NewAttachmentFromDocument2(DATABASE::"Indent Header", IndentHeader."No.");
        NewAttachmentFromDocument(IndentHeader."Incoming Document Entry No",
        Database::"Indent Header", "Document Type Filter", IndentHeader."No.");
    end;

    procedure NewAttachmentFromDocument2(TableID: Integer; DocumentNo: Code[20])
    begin
        SetRange("Document Table No. Filter", TableID);
        SetRange("Document No. Filter", DocumentNo);
        NewAttachment();

    end;
}