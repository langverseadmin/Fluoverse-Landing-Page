# UTM System Testing Guide

## 🎯 Quick Test Links

Test these URLs in your browser to verify UTM capture:

### Basic UTM Test
```
https://yourdomain.com/?utm_source=test&utm_medium=test&utm_campaign=fluency-sprint-sep-2025&utm_content=test-content&utm_term=test-term
```

### Social Media Tests
```
# LinkedIn Test
https://yourdomain.com/?utm_source=linkedin&utm_medium=social&utm_campaign=fluency-sprint-sep-2025&utm_content=teaser-post

# Instagram Test  
https://yourdomain.com/?utm_source=instagram&utm_medium=social&utm_campaign=fluency-sprint-sep-2025&utm_content=reel-video

# Twitter Test
https://yourdomain.com/?utm_source=twitter&utm_medium=social&utm_campaign=fluency-sprint-sep-2025&utm_content=thread-post
```

### Email Tests
```
https://yourdomain.com/?utm_source=email&utm_medium=email&utm_campaign=fluency-sprint-sep-2025&utm_content=email-1
```

## 🧪 Testing Steps

### 1. Frontend UTM Parsing Test
1. Open browser developer tools (F12)
2. Go to Console tab
3. Visit a test URL with UTM parameters
4. Check console for: `"UTM Parameters captured: {...}"`
5. Verify parameters are stored in sessionStorage

### 2. UTM Persistence Test
1. Visit URL with UTM parameters
2. Navigate to competition page
3. Check that UTM data persists in sessionStorage
4. Verify UTM data is still available when clicking "Join Competition"

### 3. Backend Capture Test
1. Set up your backend endpoint (`/api/track-utm`)
2. Click "Join Competition" button
3. Check backend logs for UTM data
4. Verify data is stored in your database

### 4. GA4 Integration Test
1. Set up GA4 event tracking
2. Visit test URL and complete action
3. Check GA4 Real-time reports
4. Verify UTM parameters appear in GA4

## 🔍 Debugging Checklist

### Frontend Issues
- [ ] UTM parameters visible in URL
- [ ] Console shows "UTM Parameters captured"
- [ ] sessionStorage contains utmData
- [ ] No JavaScript errors in console

### Backend Issues  
- [ ] Backend endpoint responds with 200
- [ ] UTM data appears in backend logs
- [ ] Database record created successfully
- [ ] No CORS errors

### GA4 Issues
- [ ] GA4 measurement ID configured
- [ ] Events appear in Real-time reports
- [ ] UTM parameters visible in GA4
- [ ] Attribution data correct

## 📊 Expected Data Structure

When UTM data is captured, you should see:

```json
{
  "action": "app_launch",
  "timestamp": "2025-01-15T10:30:00.000Z",
  "page_url": "https://yourdomain.com/competition.html",
  "referrer": "https://linkedin.com/...",
  "user_agent": "Mozilla/5.0...",
  "utm_source": "linkedin",
  "utm_medium": "social", 
  "utm_campaign": "fluency-sprint-sep-2025",
  "utm_content": "teaser-post",
  "utm_term": ""
}
```

## 🚨 Common Issues & Solutions

### Issue: UTM parameters not captured
**Solution**: Check URL format, ensure parameters start with `utm_`

### Issue: UTM data lost on page navigation  
**Solution**: Verify sessionStorage implementation, check for JavaScript errors

### Issue: Backend not receiving data
**Solution**: Check CORS settings, verify endpoint URL, check network tab

### Issue: GA4 not showing UTM data
**Solution**: Verify GA4 configuration, check event parameters, ensure proper tracking code

## 📈 Analytics Setup

### Google Analytics 4
1. Create custom dimensions for UTM parameters
2. Set up conversion events for "app_launch" and "competition_join"
3. Create custom reports showing UTM attribution

### Database Schema (Example)
```sql
CREATE TABLE utm_tracking (
    id SERIAL PRIMARY KEY,
    action VARCHAR(50),
    timestamp TIMESTAMP,
    page_url TEXT,
    referrer TEXT,
    user_agent TEXT,
    utm_source VARCHAR(100),
    utm_medium VARCHAR(100),
    utm_campaign VARCHAR(100),
    utm_content VARCHAR(100),
    utm_term VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);
```

## ✅ Acceptance Criteria

- [ ] UTM parameters parse correctly from URL
- [ ] UTM data persists across page navigation
- [ ] UTM data sent to backend on user actions
- [ ] UTM data stored in database
- [ ] UTM data visible in GA4
- [ ] All test links work correctly
- [ ] No JavaScript errors in console
- [ ] Backend responds successfully to all requests
