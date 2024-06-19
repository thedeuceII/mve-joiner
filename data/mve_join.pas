{$apptype console}
uses windows, kol;

const BUF_SIZE = 100000;

var f1, f2, fo: file;
	buf: array [1..BUF_SIZE] of byte;
	to_read: int64;
	bytes_read: int64;
	in_size: int64;

begin
	FileMode := 0;
	writeln ('MVE Joiner');
	if paramcount<>3 then begin
		writeln;
		writeln ('This program joins two Interplay MVE movies into one.');
		writeln;
		writeln (' usage: mve_join.exe movie1.mve movie2.mve movie_out.mve');
		exit;
	end;
	if not FileExists (paramstr(1)) then begin
		writeln ('Input file `', paramstr(1), ''' not found.');
		exit;
	end;
	if not FileExists (paramstr(2)) then begin
		writeln ('Input file `', paramstr(2), ''' not found.');
		exit;
	end;
	assign (f1, paramstr(1)); reset (f1, 1);
	assign (f2, paramstr(2)); reset (f2, 1);
	assign (fo, paramstr(3)); rewrite (fo, 1);

	writeln (' ', ExtractFileName(paramstr(1)), ' -> ', paramstr(3));
	in_size := system.filesize (f1);
	dec (in_size, 16); // cutting 16 bytes - EOF markers - from 1st file
	while (in_size > 0) do begin
		to_read := BUF_SIZE;
		if to_read > in_size then
			to_read := in_size;
		blockread (f1, buf, to_read, bytes_read);
		blockwrite (fo, buf, bytes_read);
		dec (in_size, bytes_read);
	end;

	writeln (' ', ExtractFileName(paramstr(2)), ' -> ', paramstr(3));
	seek (f2, $1A); // skipping MVE signature in 2nd file

	while not eof(f2) do begin
		blockread (f2, buf, BUF_SIZE, bytes_read);
		blockwrite (fo, buf, bytes_read);
	end;

	close (fo);
	close (f1);
	close (f2);
end.
