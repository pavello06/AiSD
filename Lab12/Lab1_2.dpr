Program Lab1_2;

Uses
  System.SysUtils;

Const
    MIN_AMOUNT_OF_PEOPLE = 1;
    MAX_AMOUNT_OF_PEOPLE = 64;
    MIN_RETIRED_NUMBER = 1;
    MAX_RETIRED_NUMBER = 64;

Type
    Pt = ^Person;
    Person = Record
        Number: Byte;
        Next: Pt;
    End;

Function ReadRetiredNumber() : Integer;
Var
    RetiredNumber: Integer;
    IsCorrect: Boolean;
Begin
    WriteLn('������� ����� ��������� K[', MIN_RETIRED_NUMBER, '; ', MAX_RETIRED_NUMBER, ']: ');
    RetiredNumber := 0;
    Repeat
        IsCorrect := True;
        Try
            ReadLn(RetiredNumber);
        Except
            IsCorrect := False;
        End;
        IsCorrect := IsCorrect And (RetiredNumber >= MIN_RETIRED_NUMBER) And (RetiredNumber <= MAX_RETIRED_NUMBER);
        If Not IsCorrect Then
            WriteLn('���������� �����: ');
    Until IsCorrect;
    ReadRetiredNumber := RetiredNumber;
End;



Procedure MakeListOfPeople(AmountOfPeople: Integer; Var ListOfPeople: Pt);
Var
    FirstPerson: Pt;
    I: Integer;
Begin
    ListOfPeople^.Number := 1;
    FirstPerson := ListOfPeople;
    For I := 2 To AmountOfPeople Do
    Begin
        New(ListOfPeople^.Next);
        ListOfPeople := ListOfPeople^.Next;
        ListOfPeople^.Number := I;
    End;
    ListOfPeople^.Next := FirstPerson;
End;

Procedure PlayRound(RetiredNumber: Integer; ListOfPeople: Pt);
Var
    Counter: Integer;
Begin
    Counter := 1;
    While ListOfPeople <> ListOfPeople^.Next Do
    Begin
        If Counter = RetiredNumber Then
        Begin
            Write(ListOfPeople^.Next^.Number, ' ');
            ListOfPeople^.Next := ListOfPeople^.Next^.Next;
            Counter := 0;
        End
        Else
            ListOfPeople := ListOfPeople^.Next;
        Inc(Counter);
    End;
    Write(' | ', ListOfPeople^.Number);
End;

Procedure PlayGame(RetiredNumber: Integer);
Var
    ListOfPeople: Pt;
    AmountOfPeople: Integer;
Begin
    WriteLn;
    For AmountOfPeople := MIN_AMOUNT_OF_PEOPLE To MAX_AMOUNT_OF_PEOPLE Do
    Begin
        Write('N = ', Format('%-3s|', [IntToStr(AmountOfPeople)]));
        New(ListOfPeople);
        MakeListOfPeople(AmountOfPeople, ListOfPeople);
        PlayRound(RetiredNumber, ListOfPeople);
        WriteLn;
    End;
End;



Var
    RetiredNumber: Integer;
Begin
    RetiredNumber := ReadRetiredNumber();
    PlayGame(RetiredNumber);

    Write(#13#10'������� ����� ������� ��� ����������...');
    ReadLn;
End.
