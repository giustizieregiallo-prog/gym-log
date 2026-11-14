# Generates icon-192.png and icon-512.png (solid #2d6a4f with a white 🏋 centred).
# Run once from the repo folder:  powershell -ExecutionPolicy Bypass -File generate-icons.ps1
Add-Type -AssemblyName System.Drawing
$emoji = [char]::ConvertFromUtf32(0x1F3CB)   # 🏋 weight lifter
foreach ($size in 192, 512) {
  $bmp = New-Object System.Drawing.Bitmap $size, $size
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $g.TextRenderingHint = 'AntiAliasGridFit'
  $g.Clear([System.Drawing.ColorTranslator]::FromHtml('#2d6a4f'))
  $font = New-Object System.Drawing.Font 'Segoe UI Emoji', ($size * 0.42), ([System.Drawing.FontStyle]::Regular), ([System.Drawing.GraphicsUnit]::Pixel)
  $fmt = New-Object System.Drawing.StringFormat
  $fmt.Alignment = 'Center'; $fmt.LineAlignment = 'Center'
  $rect = New-Object System.Drawing.RectangleF 0, ($size * 0.02), $size, $size
  $g.DrawString($emoji, $font, [System.Drawing.Brushes]::White, $rect, $fmt)
  $out = Join-Path $PSScriptRoot "icon-$size.png"
  $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
  $g.Dispose(); $bmp.Dispose()
  "wrote $out"
}
