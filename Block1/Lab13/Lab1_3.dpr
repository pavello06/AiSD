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

Function IsValid�haracteristic(Str: String; Const MIN, MAX: Integer; Condition: Boolean) : Boolean;
Begin
    IsValid�haracteristic := (Length(Str) >= MIN) And (Length(Str) <= MAX) And Condition;
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
    WriteLn('������� ������� �������� (���� 20 ��������):');
    Repeat
        ReadLn(TempLastName);
        IsValid := IsValid�haracteristic(String(TempLastName), MIN_LENGTH_LAST_NAME, MAX_LENGTH_LAST_NAME, True);
        If Not IsValid Then
            WriteLn('�������� �������!'#13#10'���������� �����:');
    Until IsValid;
    WriteLn('������� ����� �������� (7 ��������):');
    Repeat
        ReadLn(TempNumber);
        IsValid := IsValid�haracteristic(String(TempNumber), MIN_LENGTH_NUMBER, MAX_LENGTH_NUMBER, TryStrToInt(String(TempNumber), Num) And (TempNumber <> '-'));
        If Not IsValid Then
            WriteLn('�������� �����!'#13#10'���������� �����:');
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
        Write('������� Enter ��� ����������� (��� ����������� ������� ''\0''): ');
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
        Write('�������: ', Head.LastName, #13#10);
        Write('�����: ', Head.Number, #13#10);
        Head := Head.Next;
    End;
    WriteLn;
End;



Procedure SearchBy�haracteristic(Head: PSubscriber; lnMode: Char);
Var
    TempString: String;
    HasPerson: Boolean;
Begin
    WriteLn;
    If lnMode = 'l' Then
        Write('������� �������: ')
    Else
        Write('������� �����: ');
    ReadLn(TempString);
    HasPerson := False;
    While Head <> Nil Do
    Begin
        If lnMode = 'l' Then
        Begin
            If String(Head.LastName) = TempString Then
            Begin
                WriteLn('�����: ', Head.Number);
                HasPerson := True;
            End;
        End
        Else
        Begin
            If String(Head.Number) = TempString Then
            Begin
                WriteLn('�������: ', Head.LastName);
                HasPerson := True;
            End;
        End;
        Head := Head^.Next;
    End;
    If Not HasPerson Then
        WriteLn('����� ����� ���(');
    WriteLn;
End;

Procedure Search(Head: PSubscriber);
Var
    Action: Char;
Begin
    While True Do
    Begin
        WriteLn('�������� ��������:');
        WriteLn('1 - ����� �� �������');
        WriteLn('2 - ����� �� ������');
        WriteLn('3 - �����');
        Write('��� �����: ');
        ReadLn(Action);
        Case Action Of
            '1': SearchBy�haracteristic(Head, 'l');
            '2': SearchBy�haracteristic(Head, 'n');
            '3': Exit;
        End;
        Write('������� ����� ������� ��� �����������: ');
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
