import asyncio
import pathlib

from mve_joiner_redux.setting import Settings, get_settings


def mve_joiner() -> None:
    _settings: Settings = get_settings()

    async def _join_mve() -> None:
        pass

    def _remove_header(file: str) -> bytearray:
        bytes_arr: bytearray = bytearray()
        for byte in pathlib.Path(file).read_bytes():
            bytes_arr.append(byte)

        return bytes_arr[len(_settings.interplay_header) : :]

    loop = asyncio.get_event_loop()
    loop.run_until_complete(_join_mve())
