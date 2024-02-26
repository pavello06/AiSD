Program Lab1_1;

uses
  Math,
  System.SysUtils;

Const
    MIN_POWER = 0;
    MAX_POWER = 10;
    MIN_COEFFICIENT = -1000;
    MAX_COEFFICIENT = 1000;
    MIN_X = -1000;
    MAX_X = 1000;
Type
    Pt = ^Monomial;
    Monomial = Record
        Power: Integer;
        �oefficient: Integer;
        Next: Pt;
    End;

Function ReadNumber(Const MIN, MAX: Integer) : Integer;
Var
    Number: Integer;
    IsCorrect: Boolean;
Begin
    Number := 0;
    Repeat
        IsCorrect := True;
        Try
            ReadLn(Number);
        Except
            IsCorrect := False;
        End;
        IsCorrect := IsCorrect And (Number >= MIN) And (Number <= MAX);
        If Not IsCorrect Then
            WriteLn('���������� �����: ');
    Until IsCorrect;
    ReadNumber := Number;
End;

Procedure MakePolynomial(PowerOfPolynomial: Integer; Polynomial: Pt);
Var
    Power, �oefficient: Integer;
Begin
    For Power := PowerOfPolynomial DownTo 0 Do
    Begin
        WriteLn('������� ����������� ��������� a', Power, ' [', MIN_COEFFICIENT, '; ', MAX_COEFFICIENT, ']: ');
        �oefficient := ReadNumber(MIN_COEFFICIENT, MAX_COEFFICIENT);
        If �oefficient <> 0 Then
        Begin
            New(Polynomial.Next);
            Polynomial := Polynomial.Next;
            Polynomial.Power := Power;
            Polynomial.�oefficient := �oefficient;
        End;
    End;
    Polynomial.Next := Nil;
End;

Procedure ReadPolynomial(Sequence: Integer; Polynomial: Pt);
Var
    PowerOfPolynomial: Integer;
Begin
    WriteLn('������� ������� ', Sequence, ' ����������[', MIN_POWER, '; ', MAX_POWER, ']: ');
    PowerOfPolynomial := ReadNumber(MIN_POWER, MAX_POWER);
    MakePolynomial(PowerOfPolynomial, Polynomial);
End;

Procedure WritePolynomial(Polynomial: Pt);
Begin
    Polynomial := Polynomial.Next;
    While Polynomial <> Nil Do
    Begin
        If Polynomial.�oefficient > 0 Then
            Write('+');
        If Polynomial.Power > 0 Then
            Write(Polynomial.�oefficient, 'x^', Polynomial.Power)
        Else
            Write(Polynomial.�oefficient);
        Polynomial := Polynomial.Next;
    End;
    WriteLn;
End;



Function Equality(Polynomial1, Polynomial2: Pt) : Boolean;
Var
    IsEqual: Boolean;
Begin
    IsEqual := True;
    Polynomial1 := Polynomial1.Next;
    Polynomial2 := Polynomial2.Next;
    While IsEqual And (Polynomial1 <> Nil) And (Polynomial2 <> Nil) Do
    Begin
        IsEqual := (Polynomial1.Power = Polynomial2.Power) And (Polynomial1.�oefficient = Polynomial2.�oefficient);
        Polynomial1 := Polynomial1.Next;
        Polynomial2 := Polynomial2.Next;
    End;
    If (Polynomial1 <> Nil) Or (Polynomial2 <> Nil) Then
        IsEqual := False;
    Equality := IsEqual;
End;

Function Meaning(Polynomial: Pt; X: Integer) : Integer;
Var
    PolynomialMeaning, XPower, I: Integer;
Begin
    PolynomialMeaning := 0;
    While Polynomial <> Nil Do
    Begin
        XPower := 1;
        For I := 1 To Polynomial.Power Do
            XPower := XPower * X;
        PolynomialMeaning := PolynomialMeaning + Polynomial.�oefficient * XPower;
        Polynomial := Polynomial.Next;
    End;
    Meaning := PolynomialMeaning;
End;

Procedure Add(Polynomial3, Polynomial1, Polynomial2: Pt);
Begin
    Polynomial1 := Polynomial1.Next;
    Polynomial2 := Polynomial2.Next;
    While (Polynomial1 <> Nil) And (Polynomial2 <> Nil) Do
    Begin
        New(Polynomial3.Next);
        Polynomial3 := Polynomial3.Next;
        If Polynomial1.Power = Polynomial2.Power Then
        Begin
            Polynomial3.Power := Polynomial1.Power;
            Polynomial3.�oefficient := Polynomial1.�oefficient + Polynomial2.�oefficient;
            Polynomial1 := Polynomial1.Next;
            Polynomial2 := Polynomial2.Next;
        End
        Else If Polynomial1.Power > Polynomial2.Power Then
        Begin
            Polynomial3.Power := Polynomial1.Power;
            Polynomial3.�oefficient := Polynomial1.�oefficient;
            Polynomial1 := Polynomial1.Next;
        End
        Else
        Begin
            Polynomial3.Power := Polynomial2.Power;
            Polynomial3.�oefficient := Polynomial2.�oefficient;
            Polynomial2 := Polynomial2.Next;
        End;
    End;
    Polynomial3.Next := Nil;
End;



Procedure ChooseAction(Polynomial1, Polynomial2: Pt);
Var
    Action, X: Integer;
    Polynomial3: Pt;
Begin
    While True Do
    Begin
        WriteLn(#13#10'��������� - 1'#13#10'��������� �������� - 2'#13#10'�������� - 3'#13#10'����� - 4');
        Write('�������� ���� �� ��������: ');
        Action := ReadNumber(1, 4);
        WriteLn;
        Case Action Of
            1:
            Begin
                If Equality(Polynomial1, Polynomial2) Then
                    Write('���������� �����!')
                Else
                    Write('���������� �� �����!');
            End;
            2:
            Begin
                WriteLn('������� X:');
                X := ReadNumber(MIN_X, MAX_X);
                WriteLn('�������� 1 ���������� ��� X = ', X, ' �����: ', Meaning(Polynomial1, X));
                Write('�������� 2 ���������� ��� X = ', X, ' �����: ', Meaning(Polynomial2, X));
            End;
            3:
            Begin
                New(Polynomial3);
                Add(Polynomial3, Polynomial1, Polynomial2);
                Write('����� ���������: ');
                WritePolynomial(Polynomial3);
            End;
            4: Exit;
        End;
        Write(#13#10'������� ����� ������� ��� �����������...');
        ReadLn;
    End;
End;



Var
    Polynomial1, Polynomial2: Pt;
Begin
    New(Polynomial1);
    ReadPolynomial(1{Sequence}, Polynomial1);

    New(Polynomial2);
    ReadPolynomial(2{Sequence}, Polynomial2);

    WriteLn(#13#10'1 ���������: ');
    WritePolynomial(Polynomial1);

    WriteLn('2 ���������: ');
    WritePolynomial(Polynomial2);

    ChooseAction(Polynomial1, Polynomial2);
End.
