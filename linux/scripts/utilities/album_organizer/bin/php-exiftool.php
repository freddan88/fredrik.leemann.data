<?php

$phpExecutable = '';
$exifToolExecutable = 'B:\Media\Album\$Sort_files\bin\exiftool';

$directoryFiles = scandir('.');
$directoryFiles = preg_grep('/^([^.])/', $directoryFiles);

$numberSeq = (int) trim(file_get_contents("seq.log"));

if ($numberSeq) {
  $fileName = '20230527200912-20230607-000905.jpg';

  $mimeType = mime_content_type($fileName); // image/jpeg

  $fileExtension = '';
  $fileError = false;

  switch ($mimeType) {
    case 'image/jpeg':
      $dateTimeCreated = shell_exec('B:\Media\Album\$Sort_files\bin\exiftool -T -createDate -d "%Y%m%d_%H%M%S" 20230527200912-20230607-000905.jpg');
      $fileExtension = 'jpg';
      break;

    default:
      $fileError = true;
      // $dateTimeCreated = "";
      // $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
      break;
  }

  if (!$fileError) {
    $randomHex = bin2hex(random_bytes(2));

    $paddedSeq = str_pad($numberSeq, 8, 0, STR_PAD_LEFT); // 00000001

    $newFileName = trim($dateTimeCreated) . '_' . $randomHex . '_' . $paddedSeq . '.' . $fileExtension;

    file_put_contents("seq.log", $numberSeq++);

    echo $newFileName;

    rename('Sample_abc.jpg', $newFileName);
  }
}
