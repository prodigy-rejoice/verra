# Verra

> Prove your strength on-chain.



Verra is a proof-of-skill network built on Sui where users earn, risk, and grow reputation through competitive challenges.

## What is Verra

- Compete in skill challenges: Chain Reflex, Crypto Trivia, Word Stake, Pattern Breaker, Math Duel
- Stake your reputation against other players in 1v1 matches
- Win = you take their staked rep. Lose = they take yours
- Your score lives on Sui — no platform can reset it, fake it, or take it away
- Sign in with Google via zkLogin — no seed phrase, no gas fees

## Tech Stack

- Flutter (Dart) — mobile-first, MVVM + Stacked architecture
- Sui Network — on-chain reputation objects, soulbound match records
- Move smart contracts — player profiles, match settlement via PTBs
- Supabase — real-time matchmaking
- zkLogin — Google sign-in without crypto knowledge
- Sponsored transactions — zero gas fees for players

## Reputation Ranks

- Rookie (default) 
- Bronze
- Silver 
- Gold 
- Legend

## Getting Started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```