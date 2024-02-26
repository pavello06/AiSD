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


Function IsValid�haracteristic(Str: String; Const MIN, MAX: Integer; Condition: Boolean) : Boolean;
Begin
    IsValid�haracteristic := (Length(Str) >= MIN) And (Length(Str) <= MAX) And Condition;
End;

Procedure ReadPerson(Var ListOfPeople: TLinkedList);
Var
    IsValid: Boolean;
    TempLastName: TLastName;
    TempNumber: TNumber;
    Num: Integer;
Begin
    WriteLn('������� ������� �������� (���� 20 ��������):');
    Repeat
        ReadLn(TempLastName);
        IsValid := IsValid�haracteristic(String(TempLastName), MIN_LENGTH_LASTNAME, MAX_LENGTH_LASTNAME, True);
        If Not IsValid Then
            WriteLn('�������� �������!'#13#10'���������� �����:');
    Until IsValid;
    WriteLn('������� ����� �������� (���� 20 ��������):');
    Repeat
        ReadLn(TempNumber);
        IsValid := IsValid�haracteristic(String(TempLastName), MIN_LENGTH_NUMBER, MAX_LENGTH_NUMBER, TryStrToInt(String(TempNumber), Num) And (TempNumber <> '-'));
        If Not IsValid Then
            WriteLn('�������� �����!'#13#10'���������� �����:');
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
        Write('������� Enter ��� ����������� (��� ����������� ������� ''\0''): ');
        ReadLn(TempString);
        If TempString <> '\0' Then
            ReadPerson(ListOfPeople);
    Until TempString = '\0';
    ListOfPeople.Next := Nil;
End;



Procedure SearchBy�haracteristic(ListOfPeople: TLinkedList; lnMode: Char);
Var
    TempString: String;
    HasPerson: Boolean;
Begin
    WriteLn('������� ��������������: ');
    ReadLn(TempString);
    HasPerson := False;
    While ListOfPeople <> Nil Do
    Begin
        If lnMode = 'l' Then
        Begin
            If String(ListOfPeople.LastName) = TempString Then
            Begin
                WriteLn('�����: ', ListOfPeople.Number);
                HasPerson := True;
            End;
        End
        Else
        Begin
            If String(ListOfPeople.Number) = TempString Then
            Begin
                WriteLn('�������: ', ListOfPeople.LastName);
                HasPerson := True;
            End;
        End;
        ListOfPeople := ListOfPeople^.Next;
    End;
    If Not HasPerson Then
        WriteLn('����� ����� ���(');    
End;

Procedure Search(ListOfPeople: TLinkedList);
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
            '1': SearchBy�haracteristic(ListOfPeople, 'l');
            '2': SearchBy�haracteristic(ListOfPeople, 'n');
            '3': Exit;    
        End;
        Write('������� ����� ������� ��� �����������: ');
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
