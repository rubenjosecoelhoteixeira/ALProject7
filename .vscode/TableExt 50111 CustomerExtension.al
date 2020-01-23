tableextension 50111 CustomerExtension extends Customer
{
    fields
    {
        //add changes to table fields here
        field(50101; "Favorite Book"; Code[10])
        {
            TableRelation = Book."No.";
            CaptionML = ENU = 'Favorite Book';
        }
    }
}