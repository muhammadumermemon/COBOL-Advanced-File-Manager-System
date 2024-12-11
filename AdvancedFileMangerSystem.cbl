       IDENTIFICATION DIVISION.
       PROGRAM-ID. ADVANCED-FILE-MANAGER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT FILE-STATUS ASSIGN TO "FILE.STATUS".
           SELECT FILE-CONTENT ASSIGN TO "FILE.CONTENT".
           SELECT DIRECTORY-LISTING ASSIGN TO "DIRECTORY.LISTING".

       DATA DIVISION.
       FILE SECTION.

           FD  FILE-STATUS.
           01  FILE-STATUS-RECORD.
               05  FILE-NAME            PIC X(50).
               05  FILE-SIZE             PIC 9(10).
               05  FILE-TYPE             PIC X(10).
               05  FILE-CREATION-DATE   PIC X(10).
               05  FILE-MODIFICATION-DATE PIC X(10).

           FD  FILE-CONTENT.
           01  FILE-CONTENT-RECORD.
               05  FILE-CONTENT-DATA    PIC X(100).

           FD  DIRECTORY-LISTING.
           01  DIRECTORY-LISTING-RECORD.
               05  DIRECTORY-NAME        PIC X(50).
               05  DIRECTORY-PATH         PIC X(100).

       WORKING-STORAGE SECTION.

           01  COMMAND-LINE            PIC X(100).
           01  CURRENT-DIRECTORY       PIC X(100).
           01  FILE-NAME-INPUT         PIC X(50).
           01  FILE-SIZE-INPUT          PIC 9(10).
           01  FILE-TYPE-INPUT          PIC X(10).
           01  FILE-CONTENT-INPUT       PIC X(100).
           01  DIRECTORY-PATH-INPUT     PIC X(100).

           01  ERROR-MESSAGE             PIC X(100).
           01  SUCCESS-MESSAGE            PIC X(100).

           01  FILE-STATUS-FLAG         PIC X(1).
           01  DIRECTORY-LISTING-FLAG   PIC X(1).

       PROCEDURE DIVISION.
       MAIN-PROGRAM.

           DISPLAY "ADVANCED FILE MANAGER".
           DISPLAY "------------------------".

           PERFORM GET-CURRENT-DIRECTORY.

           PERFORM DISPLAY-COMMAND-LINE.

           ACCEPT COMMAND-LINE.

           IF COMMAND-LINE = "LIST"
               PERFORM DISPLAY-FILE-LIST
           ELSE IF COMMAND-LINE = "CREATE"
               PERFORM CREATE-NEW-FILE
           ELSE IF COMMAND-LINE = "DELETE"
               PERFORM DELETE-FILE
           ELSE IF COMMAND-LINE = "DIRECTORY"
               PERFORM DISPLAY-DIRECTORY-LISTING
           ELSE IF COMMAND-LINE = "EXIT"
               PERFORM TERMINATE-PROGRAM
           ELSE
               DISPLAY "INVALID COMMAND".

           GOBACK.

       GET-CURRENT-DIRECTORY.
           MOVE "C:\TEMP" TO CURRENT-DIRECTORY.

       DISPLAY-COMMAND-LINE.
           DISPLAY "Enter command (LIST, CREATE, DELETE, DIRECTORY, EXIT): ".

       DISPLAY-FILE-LIST.
           OPEN INPUT FILE-STATUS.
           READ FILE-STATUS.
           PERFORM UNTIL FILE-STATUS-RECORD = SPACES
               DISPLAY FILE-NAME
               DISPLAY FILE-SIZE
               DISPLAY FILE-TYPE
               DISPLAY FILE-CREATION-DATE
               DISPLAY FILE-MODIFICATION-DATE
               READ FILE-STATUS
           END-PERFORM.
           CLOSE FILE-STATUS.

       CREATE-NEW-FILE.
           DISPLAY "Enter file name: ".
           ACCEPT FILE-NAME-INPUT.
           DISPLAY "Enter file size: ".
           ACCEPT FILE-SIZE-INPUT.
           DISPLAY "Enter file type: ".
           ACCEPT FILE-TYPE-INPUT.
           OPEN OUTPUT FILE-CONTENT.
           WRITE FILE-CONTENT-RECORD FROM FILE-CONTENT-INPUT.
           CLOSE FILE-CONTENT.

       DELETE-FILE.
           DISPLAY "Enter file name: ".
           ACCEPT FILE-NAME-INPUT.
           DELETE FILE-CONTENT.

       DISPLAY-DIRECTORY-LISTING.
           OPEN INPUT DIRECTORY-LISTING.
           READ DIRECTORY-LISTING.
           PERFORM UNTIL DIRECTORY-LISTING-RECORD = SPACES
               DISPLAY DIRECTORY-NAME
               DISPLAY DIRECTORY-PATH
               READ DIRECTORY-LISTING
           END-PERFORM.
           CLOSE DIRECTORY-LISTING.

       TERMINATE-PROGRAM.
           DISPLAY "Exiting program...".
           STOP RUN.
