Program Lab1_3;

uses
  System.SysUtils;

Const
    MIN_LENGTH_LAST_NAME = 1;
    MAX_LENGTH_LAST_NAME = 20;

    MIN_LENGTH_NUMBER = 7;
    MAX_LENGTH_NUMBER = 7;

Type
    TLastName = String[MAX_LENGTH_LAST_NAME];
    TNumber = String[MAX_LENGTH_NUMBER];

    PSubscriber = ^TSubscriber;
    TSubscriber = Record
        LastName: TLastName;
        Number: TNumber;
        Next: PSubscriber;
    End;

Function IsValidСharacteristic(Str: String; Const MIN, MAX: Integer; Condition: Boolean) : Boolean;
Begin
    IsValidСharacteristic := (Length(Str) >= MIN) And (Length(Str) <= MAX) And Condition;
End;

Procedure AddSubscriber(Var Head, TempSubscriber: PSubscriber);
Var
    CurrSubscriber: PSubscriber;
Begin
    If Head = Nil Then
        Head := TempSubscriber
    Else
    Begin
        CurrSubscriber := Head;
        While (CurrSubscriber^.Next <> Nil) And (CurrSubscriber^.Next^.LastName < TempSubscriber^.LastName) Do
            CurrSubscriber := CurrSubscriber^.Next;
        TempSubscriber^.Next := CurrSubscriber^.Next;
        CurrSubscriber^.Next := TempSubscriber;
    End;
End;

Procedure ReadSubscriber(Var Head: PSubscriber);
Var
    IsValid: Boolean;
    TempLastName: TLastName;
    TempNumber: TNumber;
    Num: Integer;
    TempSubscriber: PSubscriber;
Begin
    WriteLn('Введите фамилию человека (макс 20 символов):');
    Repeat
        ReadLn(TempLastName);
        IsValid := IsValidСharacteristic(String(TempLastName), MIN_LENGTH_LAST_NAME, MAX_LENGTH_LAST_NAME, True);
        If Not IsValid Then
            WriteLn('Неверная фамилия!'#13#10'Попробуйте снова:');
    Until IsValid;
    WriteLn('Введите номер человека (7 символов):');
    Repeat
        ReadLn(TempNumber);
        IsValid := IsValidСharacteristic(String(TempNumber), MIN_LENGTH_NUMBER, MAX_LENGTH_NUMBER, TryStrToInt(String(TempNumber), Num) And (TempNumber <> '-'));
        If Not IsValid Then
            WriteLn('Неверный номер!'#13#10'Попробуйте снова:');
    Until IsValid;
    New(TempSubscriber);
    TempSubscriber^.LastName := TempLastName;
    TempSubscriber^.Number := TempNumber;
    TempSubscriber^.Next := Nil;
    AddSubscriber(Head, TempSubscriber);
End;

Procedure MakeSubscribers(Var Head: PSubscriber);
Var
    TempString: String;
Begin
    ReadSubscriber(Head);
    Repeat
        Write('Нажмите Enter для продолжения (для прекращения введите ''\0''): ');
        ReadLn(TempString);
        If TempString <> '\0' Then
            ReadSubscriber(Head);
    Until TempString = '\0';
    WriteLn;
End;



Procedure PrintSubscribers(Head: PSubscriber);
Begin
    While Head <> Nil Do
    Begin
        Write('Фамилия: ', Head.LastName, #13#10);
        Write('Номер: ', Head.Number, #13#10);
        Head := Head.Next;
    End;
    WriteLn;
End;



Procedure SearchByСharacteristic(Head: PSubscriber; lnMode: Char);
Var
    TempString: String;
    HasPerson: Boolean;
Begin
    WriteLn;
    If lnMode = 'l' Then
        Write('Введите фамилию: ')
    Else
        Write('Введите номер: ');
    ReadLn(TempString);
    HasPerson := False;
    While Head <> Nil Do
    Begin
        If lnMode = 'l' Then
        Begin
            If String(Head.LastName) = TempString Then
            Begin
                WriteLn('Номер: ', Head.Number);
                HasPerson := True;
            End;
        End
        Else
        Begin
            If String(Head.Number) = TempString Then
            Begin
                WriteLn('Фамилия: ', Head.LastName);
                HasPerson := True;
            End;
        End;
        Head := Head^.Next;
    End;
    If Not HasPerson Then
        WriteLn('Таких людей нет(');
    WriteLn;
End;

Procedure Search(Head: PSubscriber);
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
            '1': SearchByСharacteristic(Head, 'l');
            '2': SearchByСharacteristic(Head, 'n');
            '3': Exit;
        End;
        Write('Нажмите любую клавишу для продолжения: ');
        ReadLn;
    End;
End;


Var
    Head: PSubscriber;
Begin
    Head := Nil;
    MakeSubscribers(Head);

    PrintSubscribers(Head);

    Search(Head);
End.
