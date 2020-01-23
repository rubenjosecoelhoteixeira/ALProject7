codeunit 50112 DataUpgrade
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany();
    var
        Book: Record Book;
    begin
        if not Book.Get('DEFAULT') then
            CreateDefaultBook(Book);

        UpdateAllCustomersWithDefaultBook(Book."No.");
    end;

    trigger OnValidateUpgradePerCompany();
    var
        Cust: Record Customer;
    begin
        cust.SetRange("Favorite Book");
        if not cust.IsEmpty then
            error('There are still customers without a favorite book')
    end;

    local procedure CreateDefaultBook(var Book: Record Book);
    begin
        Book.Init;
        Book."No." := 'DEFAULT';
        Book.Insert;
    end;

    local procedure UpdateAllCustomersWithDefaultBook(BookNo: Code[20]);
    var
        Cust: Record Customer;
    begin
        Cust.setrange("Favorite Book", '');
        Cust.ModifyAll("Favorite Book", BookNo, true);
    end;

}