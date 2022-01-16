package main

import (
	"net/http"
	"sync/atomic"
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	engin := gin.Default()

	var reqCnt uint32

	engin.GET("/health", func(c *gin.Context) {
		start := time.Now()
		if cnt := atomic.AddUint32(&reqCnt, 1); cnt > 5 {
			c.AbortWithStatus(http.StatusInternalServerError)
		} else {
			c.JSON(http.StatusOK, gin.H{
				"At":      start,
				"Elapsed": time.Since(start).String(),
				"Count":   cnt,
			})
		}
	})

	engin.Run(":8080")
}
