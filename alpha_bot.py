#!/usr/bin/env python3
"""
Alpha Bot - 50% Auto-Redistribution System
"""

class AlphaBot:
    def __init__(self):
        self.redistribution_rate = 0.50  # 50% auto-redistribution
        self.reserve_pool = 0
    
    def distribute(self, amount):
        to_redistribute = amount * self.redistribution_rate
        self.reserve_pool += to_redistribute
        return amount - to_redistribute