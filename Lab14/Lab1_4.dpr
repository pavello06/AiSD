Program Lab1_4;

Uses
    System.SysUtils;

Const
    DIGITS = ['0'..'9'];
    SERVICE_LENGTH_NUMBER = 3;
    SUBSCRIBER_LENGTH_NUMBER = 7;

Type
    TNumberString = String[SUBSCRIBER_LENGTH_NUMBER];
    BiPt = ^BiElem;
    BiElem = Record
        Data: TNumberString;
        Next: BiPt;
        Prev: BiPt;
    End;
    UniPt = ^UniElem;
    UniElem = Record
        Data: TNumberString;
        Next: UniPt;
    End;



Function IsValidNumber(Number: TNumberString) : Boolean;
Var
    IsValid: Boolean;
    I: Integer;
Begin
    IsValid := True;
    I := 1;
    While IsValid And (I <= Length(Number)) Do
    Begin
        IsValid := CharInSet(Number[I], DIGITS);
        Inc(I);
    End;
    IsValid := IsValid And ((Length(Number) = SERVICE_LENGTH_NUMBER) Or (Length(Number) = SUBSCRIBER_LENGTH_NUMBER));
    IsValidNumber := IsValid;
End;

Procedure ReadNumber(Var BiListOfNumbers: BiPt; IsFirst: Boolean; MessageText: String);
Var
    Number: BiPt;
    IsValid: Boolean;
Begin
    Repeat
        IsValid := True;
        Number := BiListOfNumbers;
        ReadLn(Number^.Data);
        If IsFirst Or Not IsFirst And (Number^.Data <> '\0') Then
        Begin
            If IsValidNumber(Number^.Data) Then
            Begin
                New(BiListOfNumbers);
                Number^.Next := BiListOfNumbers;
                BiListOfNumbers^.Prev := Number;
            End
            Else
            Begin
                IsValid := False;
                WriteLn(MessageText);
            End;
        End;
    Until IsValid;
End;

Procedure MakeBiListOfNumbers(Var BiListOfNumbers: BiPt);
Begin
    WriteLn('������� ', SERVICE_LENGTH_NUMBER, ' ��� ', SUBSCRIBER_LENGTH_NUMBER, ' ������� ������(��� ����������� ������� ''\0''):');
    ReadNumber(BiListOfNumbers, True, '�� ������ ������ ���� �� ���� ������ �����!');
    Repeat
        ReadNumber(BiListOfNumbers, False, '�������� �����!');
    Until BiListOfNumbers^.Data = '\0';
    BiListOfNumbers := BiListOfNumbers^.Prev;
    BiListOfNumbers^.Next := Nil;
End;

Procedure WriteBiListOfNumbers(BiListOfNumbers: BiPt);
Begin

    WriteLn(#13#10'������ ������� ������ ������: ');
    While BiListOfNumbers <> Nil Do
    Begin
        WriteLn(BiListOfNumbers^.Data);
        BiListOfNumbers := BiListOfNumbers^.Prev;
    End;
End;

Procedure DeleteBiListOfNumbers(BiListOfNumbers: BiPt);
Begin
    While BiListOfNumbers <> Nil Do
    Begin
        Dispose(BiListOfNumbers);
        BiListOfNumbers := BiListOfNumbers^.Prev;
    End;
End;



Procedure MakeUniListOfSubscriberNumbers(UniListOfSubscriberNumbers: UniPt; BiListOfNumbers: BiPt);
Begin
    While BiListOfNumbers <> Nil Do
    Begin
        If Length(BiListOfNumbers^.Data) = SUBSCRIBER_LENGTH_NUMBER Then
        Begin
            New(UniListOfSubscriberNumbers^.Next);
            UniListOfSubscriberNumbers := UniListOfSubscriberNumbers^.Next;
            UniListOfSubscriberNumbers^.Data := BiListOfNumbers^.Data;
        End;
        BiListOfNumbers := BiListOfNumbers^.Prev;
    End;
    UniListOfSubscriberNumbers^.Next := Nil;
End;

Procedure SortUniListOfSubscriberNumbers(UniListOfSubscriberNumbers: UniPt);
Var
    UniFirstNumber: UniPt;
    CountOfSubscriberNumbers, I, J: Integer;
    TempNember: TNumberString;
Begin
    UniFirstNumber := UniListOfSubscriberNumbers^.Next;
    UniListOfSubscriberNumbers := UniFirstNumber;
    CountOfSubscriberNumbers := 0;
    While UniListOfSubscriberNumbers <> Nil Do
    Begin
        Inc(CountOfSubscriberNumbers);
        UniListOfSubscriberNumbers := UniListOfSubscriberNumbers^.Next;
    End;
    For I := 1 To CountOfSubscriberNumbers - 1 Do
    Begin
        UniListOfSubscriberNumbers := UniFirstNumber;
        For J := 1 To CountOfSubscriberNumbers - I Do
        Begin
            If StrToInt(String(UniListOfSubscriberNumbers^.Data)) > StrToInt(String(UniListOfSubscriberNumbers^.Next^.Data)) Then
            Begin
                TempNember := UniListOfSubscriberNumbers^.Data;
                UniListOfSubscriberNumbers^.Data := UniListOfSubscriberNumbers^.Next^.Data;
                UniListOfSubscriberNumbers^.Next^.Data := TempNember;
            End;
            UniListOfSubscriberNumbers := UniListOfSubscriberNumbers^.Next;
        End;
    End;
End;

Procedure WriteUniListOfSubscriberNumbers(UniListOfSubscriberNumbers: UniPt);
Begin
    WriteLn(#13#10'������ ������� ��������� �� �����������: ');
    UniListOfSubscriberNumbers := UniListOfSubscriberNumbers^.Next;
    If UniListOfSubscriberNumbers = Nil Then
        WriteLn('��� ��� ��������� :(');
    While UniListOfSubscriberNumbers <> Nil Do
    Begin
        WriteLn(UniListOfSubscriberNumbers^.Data);
        UniListOfSubscriberNumbers := UniListOfSubscriberNumbers^.Next;
    End;
End;

Procedure DeleteUniListOfSubscriberNumbers(UniListOfSubscriberNumbers: UniPt);
Begin
    While UniListOfSubscriberNumbers <> Nil Do
    Begin
        Dispose(UniListOfSubscriberNumbers);
        UniListOfSubscriberNumbers := UniListOfSubscriberNumbers^.Next;
    End;
End;



Var
    BiListOfNumbers: BiPt;
    UniListOfSubscriberNumbers: UniPt;
Begin
    New(BiListOfNumbers);
    BiListOfNumbers^.Prev := Nil;
    MakeBiListOfNumbers(BiListOfNumbers);
    WriteBiListOfNumbers(BiListOfNumbers);

    New(UniListOfSubscriberNumbers);
    MakeUniListOfSubscriberNumbers(UniListOfSubscriberNumbers, BiListOfNumbers);
    DeleteBiListOfNumbers(BiListOfNumbers);
    SortUniListOfSubscriberNumbers(UniListOfSubscriberNumbers);
    WriteUniListOfSubscriberNumbers(UniListOfSubscriberNumbers);
    DeleteUniListOfSubscriberNumbers(UniListOfSubscriberNumbers);

    Write(#13#10'������� ����� ������� ��� ����������...');
    ReadLn;
End.
