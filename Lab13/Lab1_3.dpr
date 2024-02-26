Program Lab1_3;

Uses
    SysUtils;

Const
    MIN_LENGTH_LASTNAME = 1;
    MAX_LENGTH_LASTNAME = 20;
    MIN_LENGTH_NUMBER = 1;
    MAX_LENGTH_NUMBER = 20;

Type
    TLastName = String[MAX_LENGTH_LASTNAME];
    TNumber = String[MAX_LENGTH_NUMBER];

    TLinkedList = ^TPerson;

    TPerson = Record
        LastName: TLastName;
        Number: TNumber;
        Next: TLinkedList;
    End;


Function IsValidСharacteristic(Str: String; Const MIN, MAX: Integer; Condition: Boolean) : Boolean;
Begin
    IsValidСharacteristic := (Length(Str) >= MIN) And (Length(Str) <= MAX) And Condition;
End;

Procedure ReadPerson(Var ListOfPeople: TLinkedList);
Var
    IsValid: Boolean;
    TempLastName: TLastName;
    TempNumber: TNumber;
    Num: Integer;
Begin
    WriteLn('Введите фамилию человека (макс 20 символов):');
    Repeat
        ReadLn(TempLastName);
        IsValid := IsValidСharacteristic(String(TempLastName), MIN_LENGTH_LASTNAME, MAX_LENGTH_LASTNAME, True);
        If Not IsValid Then
            WriteLn('Неверная фамилия!'#13#10'Попробуйте снова:');
    Until IsValid;
    WriteLn('Введите номер человека (макс 20 символов):');
    Repeat
        ReadLn(TempNumber);
        IsValid := IsValidСharacteristic(String(TempLastName), MIN_LENGTH_NUMBER, MAX_LENGTH_NUMBER, TryStrToInt(String(TempNumber), Num) And (TempNumber <> '-'));
        If Not IsValid Then
            WriteLn('Неверный номер!'#13#10'Попробуйте снова:');
    Until IsValid;
    New(ListOfPeople^.Next);
    ListOfPeople := ListOfPeople^.Next;
    ListOfPeople.LastName := TempLastName;
    ListOfPeople.Number := TempNumber;
End;

Procedure MakeListOfPeople(ListOfPeople: TLinkedList);
Var
    TempString: String;
Begin
    ReadPerson(ListOfPeople);
    Repeat
        Write('Нажмите Enter для продолжения (для прекращения введите ''\0''): ');
        ReadLn(TempString);
        If TempString <> '\0' Then
            ReadPerson(ListOfPeople);
    Until TempString = '\0';
    ListOfPeople.Next := Nil;
End;



Procedure SearchByСharacteristic(ListOfPeople: TLinkedList; lnMode: Char);
Var
    TempString: String;
    HasPerson: Boolean;
Begin
    WriteLn('Введите характеристику: ');
    ReadLn(TempString);
    HasPerson := False;
    While ListOfPeople <> Nil Do
    Begin
        If lnMode = 'l' Then
        Begin
            If String(ListOfPeople.LastName) = TempString Then
            Begin
                WriteLn('Номер: ', ListOfPeople.Number);
                HasPerson := True;
            End;
        End
        Else
        Begin
            If String(ListOfPeople.Number) = TempString Then
            Begin
                WriteLn('Фамилия: ', ListOfPeople.LastName);
                HasPerson := True;
            End;
        End;
        ListOfPeople := ListOfPeople^.Next;
    End;
    If Not HasPerson Then
        WriteLn('Таких людей нет(');    
End;

Procedure Search(ListOfPeople: TLinkedList);
Var
    Action: Char;
Begin
    While True Do
    Begin
        WriteLn('Выберите действие:');
        WriteLn('1 - поиск по фамилии');
        WriteLn('2 - поиск по номеру');
        WriteLn('3 - выход');
        Write('Ваш выбор: ');
        ReadLn(Action);
        Case Action Of
            '1': SearchByСharacteristic(ListOfPeople, 'l');
            '2': SearchByСharacteristic(ListOfPeople, 'n');
            '3': Exit;    
        End;
        Write('Нажмите любую клавишу для продолжения: ');
        Read;
    End;
End;



Var
    ListOfPeople: TLinkedList;
Begin
    New(ListOfPeople);
    MakeListOfPeople(ListOfPeople);
    
    Search(ListOfPeople);
End.
