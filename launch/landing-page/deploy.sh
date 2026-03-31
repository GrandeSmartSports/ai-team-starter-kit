#!/bin/bash
# Deploy the AI Team Builders landing page to Vercel
#
# Prerequisites:
#   npm install -g vercel   (one-time setup)
#   vercel login            (one-time setup)
#
# Usage:
#   cd launch/landing-page
#   chmod +x deploy.sh
#   ./deploy.sh
#
# This deploys index.html to Vercel and gives you a live URL.
# You can then set up a custom domain in the Vercel dashboard.

echo ""
echo "Deploying AI Team Builders landing page to Vercel..."
echo ""

# Check if vercel is installed
if ! command -v vercel &> /dev/null; then
    echo "Vercel CLI not found. Install it with:"
    echo "  npm install -g vercel"
    echo ""
    echo "Then log in with:"
    echo "  vercel login"
    exit 1
fi

# Deploy
vercel --prod

echo ""
echo "Done! Your landing page is live."
echo ""
echo "Next steps:"
echo "  1. Copy the URL above"
echo "  2. Replace {YOUR_LANDING_PAGE} in PITCH.md and social-media-posts.md"
echo "  3. Set up a custom domain in the Vercel dashboard (optional)"
echo ""
