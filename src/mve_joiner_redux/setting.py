import pydantic_settings

from mve_joiner_redux import const_interplay_header


class Settings(pydantic_settings.BaseSettings):
    interplay_header: bytearray = bytearray(const_interplay_header)


def get_settings() -> Settings:
    return Settings()
