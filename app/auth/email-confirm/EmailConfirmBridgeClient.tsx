'use client'

import { APP_STORE_URLS } from '@/lib/config'
import { useEffect, useState } from 'react'

const APP_SCHEME_PATH = 'com.fluoverse.app://auth/email-confirm'

function buildAppTarget(): string {
  if (typeof window === 'undefined') return APP_SCHEME_PATH
  const raw = window.location.hash
  const inner = raw.startsWith('#') ? raw.slice(1) : raw
  return inner ? `${APP_SCHEME_PATH}#${inner}` : APP_SCHEME_PATH
}

export default function EmailConfirmBridgeClient() {
  const [target, setTarget] = useState(APP_SCHEME_PATH)
  const [phase, setPhase] = useState<'trying' | 'fallback'>('trying')

  useEffect(() => {
    const t = buildAppTarget()
    setTarget(t)
    window.location.href = t
    const id = window.setTimeout(() => setPhase('fallback'), 1600)
    return () => window.clearTimeout(id)
  }, [])

  return (
    <div className="mx-auto w-full max-w-md rounded-2xl border border-black/10 bg-white/95 px-8 py-10 text-center shadow-lg">
      <h1 className="text-xl font-semibold tracking-tight text-[#2D185A]">
        {phase === 'trying' ? 'Opening Fluverse…' : 'Continue in the app'}
      </h1>
      <p className="mt-4 text-[15px] leading-relaxed text-black/65">
        {phase === 'trying'
          ? "Hang on — we're handing you back to the app to finish signup."
          : "Your email is verified. Tap below to open Fluverse with your login. If the app doesn't open, install it first or sign in manually."}
      </p>

      <a
        href={target}
        className="mt-6 inline-flex w-full items-center justify-center rounded-xl bg-[#6C4BCF] px-5 py-3.5 font-semibold text-white shadow-md hover:bg-[#5a3daf]"
      >
        Open Fluverse
      </a>

      <div className="mt-8 flex flex-col gap-3 border-t border-black/10 pt-6 text-sm text-black/60">
        <span>{"Don't have the app?"}</span>
        <div className="flex flex-col gap-2 sm:flex-row sm:justify-center">
          <a
            href={APP_STORE_URLS.ios}
            className="rounded-lg border border-black/15 px-4 py-2 font-medium text-[#2D185A] hover:bg-black/[0.03]"
          >
            App Store
          </a>
          <a
            href={APP_STORE_URLS.android}
            className="rounded-lg border border-black/15 px-4 py-2 font-medium text-[#2D185A] hover:bg-black/[0.03]"
          >
            Google Play
          </a>
        </div>
      </div>
    </div>
  )
}
