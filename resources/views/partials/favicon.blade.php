@php
    $favicon = \App\Models\PengaturanMedia::where('jenis_data', 'fav icon')->where('stt_aktif', 1)->first();
    $faviconFile = $favicon->nama_file ?? 'sultan-logo.png';
    $faviconPath = $faviconFile === 'sultan-logo.png'
        ? asset('config_media/sultan-favicon.svg') . '?v=1'
        : asset('config_media/' . $faviconFile);
@endphp
<link rel="icon" href="{{ $faviconPath }}">
<link rel="shortcut icon" href="{{ $faviconPath }}">
